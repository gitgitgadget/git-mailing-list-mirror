From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [JGIT PATCH v2 21/24] Added the class LightFileTreeIterator and
 a test for it.
Date: Wed, 14 May 2008 16:27:30 +0200
Message-ID: <482AF6D2.6080800@gnu.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-22-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Wed May 14 16:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwHxz-0003FY-HH
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbYENO1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbYENO1f
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:27:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:10684 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYENO1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:27:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1431372nfc.21
        for <git@vger.kernel.org>; Wed, 14 May 2008 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=xyheBOxic85VxNPOS/RxYyZzIpns5vVzVCv0lyf9Lpc=;
        b=klSuuaXz5udWyK2tugh2gLv2dHPQJwedZo/qpm9J/G0/b5tr7mJrfla9khaAb0+9XITr6c+MsqySf67ewb6NiLuUmbdWxLub9kDHCi4b4V4JwwG69FwLM3k7qc+mQ+42O8YaX322McUadjQ5fZYrIAb0u7QFxMUgV0L7MqN9xXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=eTePxl/UZLwZdf1Y+iAQfZGVs1io1EgEhshn0KuqoCcqJhGcLwLSpAyvWyKRuTRLAljsQtEigt5cNNBYQngiVtnms3D7iGQeiRCa6ihhbbd61VF2qGFdxag45/EjHfdRmhXFtIjb+QVKJY4q8mADG8QuUF/Rg2mPOcyIdU5I9Mc=
Received: by 10.125.70.14 with SMTP id x14mr454803mkk.33.1210775251259;
        Wed, 14 May 2008 07:27:31 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 3sm1442917fge.3.2008.05.14.07.27.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 07:27:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <1210623222-24908-22-git-send-email-florianskarten@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82103>


> +	void findMorePathesIfNessesary() {
> +	void findMorePathes

findMorePaths. :-)

Paolo
