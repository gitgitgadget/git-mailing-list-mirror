From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: failed to push
Date: Mon, 01 Mar 2010 13:23:10 -0800
Message-ID: <4B8C303E.7050605@gmail.com>
References: <4B8C2E68.3020507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bkorb@gnu.org
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmD5K-0001uS-Gz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0CAVXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:23:19 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:51355 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab0CAVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:23:18 -0500
Received: by bwz4 with SMTP id 4so2206864bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eClQrz/7xSvCIq/Av03zHqMfSc+IuEXYtDlFyEB+XNU=;
        b=kcYgSEffR5cY2pO73Lz/UErX79VD/B90t33UrZ7gI8XKtLdHGg9HWZA4eauOnnZ92y
         mImncQiuPryHz8HdxHHdSOM+8rdeEYIWTOm/1OZqSwciw+iVy1VO9rxw6QiX2rWLsEwi
         ZfriSnykVCZg2Q3Rs5zK4/v0eGEeABOGm4QDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kiTLMaCZNYZ4u+Up0MMD5Z1aNa1FhOD5Bc2sy16EW8jrHlvNSwrXdWU3l7ze5rKKOX
         mgKhlDEyf7sbCLZFLDCylbUbai29mzkywpOjcM44kabtw2T06sWtNbkIDSi/58mwziEw
         1InxO//ubc8XCJ8FzCQXaBEsO1gU5uaGYM9Mc=
Received: by 10.103.76.37 with SMTP id d37mr4053474mul.105.1267478593605;
        Mon, 01 Mar 2010 13:23:13 -0800 (PST)
Received: from ?10.10.1.101? (adsl-75-0-176-14.dsl.pltn13.sbcglobal.net [75.0.176.14])
        by mx.google.com with ESMTPS id t10sm20185039muh.25.2010.03.01.13.23.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:23:12 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B8C2E68.3020507@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141351>

Bruce Korb wrote:
> Hi,
> 
> This message has no meaning at all.  I know it failed to push.
> I can tell from the comment "[rejected]".  It would be nice
> to know *WHY* it was rejected so I can fix the problem.
> How do I determine the cause, please?  Thank you!!  Regards, Bruce
> 
> $ git push
> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
>  ! [rejected]        master -> master (non-fast forward)
> error: failed to push some refs to 'ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen'
> 

A little follow up context:

I used the "git gui citool".  I saw a button to allow an amendment to a
previous checkin.  That seemed most appropriate, so I did that.  I had
previously pushed the commit to the sourceforge repository, so my guess
was that pushing would amend the checkin at sourceforge, too.  Nope.
Won't let me push.  Won't tell me why, either.  Now what?  Thanks.
