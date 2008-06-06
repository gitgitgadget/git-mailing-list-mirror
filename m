From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Fri, 6 Jun 2008 11:28:59 +0600
Message-ID: <7bfdc29a0806052228s2fe764d1pe5d2b8e129115c77@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Jun 06 07:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4UWR-0007SQ-Qe
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYFFF3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYFFF3B
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:29:01 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:19079 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYFFF3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:29:00 -0400
Received: by yw-out-2324.google.com with SMTP id 9so602274ywe.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uoVm4aEXOIQVXYbi6UWW/IdBSptvwaKxWXt8Z+yoxHM=;
        b=qnk7/DgkcB4xH7MS/GNCBo5wW6BOfk0iVnCzkS2GZOZkfuCWfI+UaBJaGjWwP6vTwd
         vDea3bEES6nh5AAc4b1dggzQW+MSANoOO10ge4PYhtdPsrbUuoyDfMR84xaUq1C+DSW3
         wXqCKQwInurfJWdtnkfNI/H2peQq0oTN3cx/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G9J0oOeJ7cgfZVI5XMiKZW3FMstEyNwFxBMQCYhdpnGS2CULlKiA/efRa1sBkTXbQG
         FaQjoMq4TwHs3RzyA6DE0cxeTN9mYlS1U+xUAcWLlYcM8shEfAJ8/oP6N/TaDvXVqHVG
         BqVcvpZyaEGpyAfbxxCBXlu8JIurwC7K3T1IE=
Received: by 10.151.42.6 with SMTP id u6mr2803209ybj.213.1212730139177;
        Thu, 05 Jun 2008 22:28:59 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Thu, 5 Jun 2008 22:28:59 -0700 (PDT)
In-Reply-To: <20080604195934.GU12896@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84024>

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

I have just tested it and it works fine. Now maven is configured to
use the existing locations for source and it builds fine.

Best regards,

Imran

PS: This is the link to the commit
http://repo.or.cz/w/egit/imyousuf.git?a=commit;h=7c69b95cee245edd0701e09d5f0357f7ffbbd9ea
>
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
