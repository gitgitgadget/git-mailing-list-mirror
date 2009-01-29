From: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Thu, 29 Jan 2009 12:46:56 +1000
Message-ID: <d30068860901281846v65baf431mdab5fe961ef9407d@mail.gmail.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>
	 <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
	 <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com>
	 <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMx9-0006Y3-0U
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZA2Cq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZA2Cq7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:46:59 -0500
Received: from ag-out-0708.google.com ([72.14.246.249]:40883 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbZA2Cq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:46:58 -0500
Received: by ag-out-0708.google.com with SMTP id 26so2598050agb.10
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 18:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WIAXXM3brJP7PNfdC4k3Kda/QBdbhOsRn25nGjfPZhA=;
        b=enTS07KW2Iq3F+XU614+2ZDJK1gpgMixTbyEriIls3aD+uWDOfQFL+efflg97IYHia
         2U/x+2JTCYTEtJePbKrwPZx1yIid6hgb53BMAG0KzBXiNYIA0XlZ3djzFcE8cL+6tZa1
         +r0j3qpvaQ1B3CzYra/uCnI7C1gZOPtCMMxWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BlNfUlLlY7UAvu4SQ6ITkVlmGvUHAMyE9g3JFJcdLF9ir5YmJ+lf8ilRJaT/ocGKvF
         RRInEMuIfnT3sUy0xB54z/IDzyYtPNKqAo4IGF3ZWamc344dcTBZa+Yeoik+C95Ery/7
         fQ3BOehrDLunDasvFp+RVK6cq8Hl6lK2+ltRA=
Received: by 10.142.193.13 with SMTP id q13mr136683wff.277.1233197217045; Wed, 
	28 Jan 2009 18:46:57 -0800 (PST)
In-Reply-To: <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107619>

does the concept of me setting up my own central git server as well
make any sense from the point of view of a way to ensure I can (when
I'm not remote) "check-in" to the central git server & thereby keep a
separate copy of my code (i.e. effectively a backup)


2009/1/29 Martin Langhoff <martin.langhoff@gmail.com>:
> On Thu, Jan 29, 2009 at 3:15 PM, James Pickens <jepicken@gmail.com> wrote:
>> Greg Hauptmann <greg.hauptmann.ruby@gmail.com> wrote:
>>> Do you recommend "git" (over svn) for a 1-person team???
>>
>> Yes, emphatically.  I do it myself all the time.
>
> +1!
>
>  - offline work on your laptop
>  - "git stash"
>  - keep various branches (experimental, feature, stable...), with
> untold flexibility for cherrypicking, merges, etc
>  - bisect!
>  - visualise things with gitk
>  - search with gitk for specific bits of code, changes (pickaxe), etc
>
> once you start... it's a bit addictive...
>
>
> m
> --
>  martin.langhoff@gmail.com
>  martin@laptop.org -- School Server Architect
>  - ask interesting questions
>  - don't get distracted with shiny stuff  - working code first
>  - http://wiki.laptop.org/go/User:Martinlanghoff
>



-- 
Greg
http://blog.gregnet.org/
