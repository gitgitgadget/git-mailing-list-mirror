From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 15:43:02 +0100
Message-ID: <38b2ab8a0703240743t3ca2b091w12072046ee03dd5@mail.gmail.com>
References: <200703231022.00189.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 15:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV7Sp-000555-JO
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 15:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbXCXOnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 10:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXCXOnI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 10:43:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5649 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXCXOnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 10:43:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1251242uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 07:43:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f3K+0sUAJnnS3ca3yCF0qWgplOUmh0oeUTu8pzxlVns4h7ECJnQ1S8TLFiTOI83Srp+DwwEVa7eu5HlMCjwuNm0s9YpcGXo/von0+CcvDfJUwd8S/DzIkXhFTRJRQLEj150BPw0tWszhXyyil0lWcEu9DtbFkyjIMTIT9FBJ60k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1OGb38QKbcOydQ2vobt8Q3qtgYyvFNs4/JrCaW7wBSjOhkx8rMslzspn42kV1wNOoq8is/wYoy4J7kcgtgFfmoLHpWapLADRSENQ4OCSGJbfUNIGVMPU7ruGpdaYOgZYRql8Y0imjtflkzR0P7PextvpdRWkmUXLffOOFe/+/w=
Received: by 10.114.168.1 with SMTP id q1mr1719148wae.1174747382750;
        Sat, 24 Mar 2007 07:43:02 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Sat, 24 Mar 2007 07:43:02 -0700 (PDT)
In-Reply-To: <200703231022.00189.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43002>

Hi,

On 3/23/07, Andy Parkins <andyparkins@gmail.com> wrote:
> Now that we have a post-receive hook; the update hook's only job is to
> decide is a particular update is allowed or not.
>
> This example hook removes all of the functionality that should now
> rightly be done by the post-receive hook.  In particular: the generation
> of notification emails.
>

I would like to use this hook not for sending update annoucements by
emails but rather for keeping those annoucements into files that I
could published on the project site for example.

Are there any simple ways to enable this behaviour from your hooks ?

thanks
-- 
Francis
