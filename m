From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 15:02:21 +0200
Message-ID: <237967ef0806200602v6b95939fm2663be849799e2de@mail.gmail.com>
References: <20080620082034.GA24913@elte.hu>
	 <m3d4mcmq20.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gHE-00038b-UG
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYFTNCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbYFTNCX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:02:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:2370 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYFTNCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:02:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5660060rvb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tYTMqju0/jBpEyvV+PP5yCsPMySiyGvJMK0/yNz3Vr8=;
        b=L43qgAFtD2tIMS1+9uyjp2mYflgpPtzUnIdK8U6hapRMkoSj6mdGG03tfv4N2MVZjn
         S9Zb+kqjrKX/yoJvpHMcQz0FoejS8tlabOgjlHEdiEI7vX1qiMs6ELDg7Sc46COIKTPS
         TB7tsWGw8HfiBF1XHbty/BMq8QcapBg8NEyvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EYzIRXAY//gM6N8bb6RO6kZaGGSwk4IqZCpGkXrofPK4rEnkuN+ppzM5kgKlyQO1g0
         22GH/F3VSPzL+F3fyjmovyrme6sl8+hiStNYkHaM4if+d4I4K6W2o5TgI/5DgmDz7ZPQ
         v1kuw73dQHPKbk1Kk6f6/12YEQNVACR8djnPU=
Received: by 10.141.176.6 with SMTP id d6mr4731821rvp.292.1213966941692;
        Fri, 20 Jun 2008 06:02:21 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Fri, 20 Jun 2008 06:02:21 -0700 (PDT)
In-Reply-To: <m3d4mcmq20.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2008/6/20 Jakub Narebski <jnareb@gmail.com>:

> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
> documented anywhere, though), so you could have used
>
>        git diff 7def2be1^!
>
>>    [ time passes as i read the manpage - the final thing i do when
>>      every other measure fails ;-) ]

With some grepping, i found this in git-rev-parse,

       Two other shorthands for naming a set that is formed by a
commit and its parent
       commits exists. r1^@ notation means all parents of r1. r1^!
includes commit r1
       but excludes its all parents.

-- 
Mikael Magnusson
