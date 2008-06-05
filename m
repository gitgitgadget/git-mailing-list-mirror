From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Thu, 5 Jun 2008 08:31:13 +0600
Message-ID: <7bfdc29a0806041931n1490883drda3b4abe0b7032c3@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
	 <20080604042703.GQ12896@spearce.org>
	 <320075ff0806032340k9814a81g196e0417d42a3f6@mail.gmail.com>
	 <7bfdc29a0806032346r433e003exc7408f1ff626457d@mail.gmail.com>
	 <20080604195934.GU12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 04:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K45Gq-0001TN-QI
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 04:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbYFECbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 22:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbYFECbP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 22:31:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:7925 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbYFECbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 22:31:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so237782ywe.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 19:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2IZWd3WMezMS41BOFIMkuhrPhCF8Eb5zUCZTJcKxbzs=;
        b=b6blO+HM+sG/0UlRBcMVq9y9/xGQMOxhRglB7GJ9Z8Yt5J1v8qdBuLDTXpA6EpzbhG
         dfg+DZjLaC77Jc8R+o6MjWI6RSGiKiMr1CplUV0hHo/UhHMLS0rgsB2Lwc/LJD1mXMfR
         nnMEpjbgGXkhdGIIBa66ph788DPrWLX7eDoZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nJcO04SmlY9cbFCONHL/Tg9Od3pxG65wKJYhnErWDzT2sLJs2sbfMq5Yo+Ns7oXgTB
         cGdGQsDy660N2q82lu3BkC5ZvoPI2Ek+AREF1hEndX4v0H7zGM+eyYEB6OqSWm8HSBHK
         YW3w9UcvCo7vnGV8Wu5NGUtDAciEaQIx0nY7U=
Received: by 10.150.144.9 with SMTP id r9mr1092928ybd.41.1212633073704;
        Wed, 04 Jun 2008 19:31:13 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Wed, 4 Jun 2008 19:31:13 -0700 (PDT)
In-Reply-To: <20080604195934.GU12896@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83845>

On Thu, Jun 5, 2008 at 1:59 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> On Wed, Jun 4, 2008 at 12:40 PM, Nigel Magnay <nigel.magnay@gmail.com> wrote:
>> >>
>> >> But this shows one reason why I don't use Maven I think.  The
>> >> fact that we need a "java" directory to hold our java code.
>> >> What if another build system wants a different name?  Grumble.
>> >>
>> >
>> > You don't. Just set the appropriate config item in pom.xml
>> > (sourceDirectory possibly, but my memory isn't good this morning) and
>> > you can use 'src' as it is currently. src/main/java is just the
>> > default.
>>
>> You are absolutely right in fact (your memory did not betray ;)) its
>> <project><build><sourceDirectory>.
>
> If we can avoid doing this rename and instead just configure Maven
> to use the existing directory it would be better.  Then we don't
> have to bother everyone's branches with this rename business.
>

Will give it a try and let all know.

Best regards,

Imran

> --
> Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
