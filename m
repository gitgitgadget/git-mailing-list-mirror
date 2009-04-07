From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Showing the version of a file that's in the Index.
Date: Tue, 7 Apr 2009 16:15:27 -0400
Message-ID: <c115fd3c0904071315s6cb8812ajcdc98357f9750716@mail.gmail.com>
References: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
	 <200904072210.05591.markus.heidelberg@web.de> <874ox0w7ak.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: markus.heidelberg@web.de, Git Mailing List <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHjp-0004Md-V8
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbZDGUPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 16:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755482AbZDGUP3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:15:29 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:3625 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbZDGUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:15:29 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2784768yxl.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wH4tJqQmihTwb3PA3a5EPzFSdAlx04iNcmN6mTgFO2A=;
        b=MMy63VAHIczu/Qa1GQyinzNQRI6XTqOGnIEIl0/R8wYUCZwgfhw6mINuxkeDTfboqV
         YlEHaD+2WYhkxciTPFB09jjsWy72T7azDqNMcWCAPI7rGPHlP4b3vNhIhTn67nvePUmN
         p5HhsEw4mlPDGQbwS0izrlVwPttBCCIiRnVP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m9YKx1vuRyZmZ/yS+tegGpyXhR1YQClBzOwL49h64tgS1d/ovPaia9RccCuSHtclRl
         oS1tTJtHI1bLVwvp7FImBDnZrpVsBdEu+qKO9TiPz/SesdG6v49e/DQtRQYLJkY7ralO
         JXICmUa/TWcRMk/PIQJ3JvdB8zXvXAfaeD89o=
Received: by 10.100.138.10 with SMTP id l10mr487569and.136.1239135327703; Tue, 
	07 Apr 2009 13:15:27 -0700 (PDT)
In-Reply-To: <874ox0w7ak.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115984>

On Tue, Apr 7, 2009 at 4:14 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> On 2009-04-07 22:10 (+0200), Markus Heidelberg wrote:
>
>> Tim Visher, 07.04.2009:
>>> How do you go about showing the version of the file that's in an
>>> index.
>>
>> With version do you mean content? Then
>>
>>     git cat-file -p :0:file
>> or
>>     git cat-file -p :file
>
> Or
>
>    git show :file
>

Nice.  Thank you!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
