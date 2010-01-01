From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: 65c042d4 broke `remote update' without named group
Date: Fri, 1 Jan 2010 10:14:28 +0100
Message-ID: <6672d0161001010114g1979eba0pf7de8a78cf979b7c@mail.gmail.com>
References: <20091229234959.GA94644@les.ath.cx>
	 <be6fef0d1001010100u7ebf25beydd2ff11ef71a9d66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: YONETANI Tomokazu <qhwt+git@les.ath.cx>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 10:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQdae-0006Pp-13
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 10:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0AAJOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2010 04:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212Ab0AAJOb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 04:14:31 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48723 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0AAJOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jan 2010 04:14:30 -0500
Received: by ewy19 with SMTP id 19so5204049ewy.21
        for <git@vger.kernel.org>; Fri, 01 Jan 2010 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GvMvbzG1Hc4e9kPj6YpgVWDW5lBAbXtxbLmckuCqZ14=;
        b=D9osdTdpIx49cGMrjyq8q+34DKsQIYXYSaH9QWU9QFDVPos4B6IQxu+aoILEMc6DeW
         hE4fbvAYoACjPY4Uo4+nfF3eJfvHnucvq+ipm+DyQNjMRloKxnixeOFYh5JzunbFYkDU
         1zu7VyBA9+a6PXLqlMPGotiy3N47+g+oVEuVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KVCEBrObcMQGTUW5J/ACgO9vf89jCpVripDOfz1jfvvjvy57+AUN91inZnyVmvrPvY
         awbYTLQZGUCjMEo+QTifNh0TXTW198wCqxbcMvsmr3jilHmhLgvZZge79nORKqWCxDBm
         VNWk5hNtvk+fbiDOXBp/F/FGbQLegzPU9tdcg=
Received: by 10.216.88.75 with SMTP id z53mr7015470wee.46.1262337269074; Fri, 
	01 Jan 2010 01:14:29 -0800 (PST)
In-Reply-To: <be6fef0d1001010100u7ebf25beydd2ff11ef71a9d66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136006>

2010/1/1 Tay Ray Chuan <rctay89@gmail.com>:

> Bj=C3=B6rn (added to Cc list), you seem to have been the main author =
of
> 'bg/fetch-multi', do you have any idea on this?

Yes. I have fixed the problem and my correction is included in
the latest 'pu' (bg/maint-remote-update-default).

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
