From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 12:46:53 +0600
Message-ID: <7bfdc29a0806032346r433e003exc7408f1ff626457d@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
	 <20080604042703.GQ12896@spearce.org>
	 <320075ff0806032340k9814a81g196e0417d42a3f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mmn-0008MO-DN
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYFDGrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbYFDGrA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:47:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:1556 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYFDGq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:46:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1016678ywe.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 23:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YebpIfIZutrXMeyuVe/790YaH4GvFWevMXTP3YL7PIs=;
        b=Ibqfvr2fx5SGOvdZ9vw7+dgAERhO8INluibkYoqSBm4f5zQdveYRb8IYHIXKlo0aFX7y3KITNvkx1SpFT+NVEDwsIEMaZlks8cRDrjrnNSlBnktpBaNgSveRceoOshmwFus5rGNKW/e6YNL+NLwufyOmsk0ZI3m9deIquHCYwvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWh/ivwrOfTTUYePIFL2LbZ67eN2uYA8Br7WK64pG9RbfEtodknDjXtzLrYVHZNWASjDiKghc5wyAzU8OwV//vWboT2eF+nlMCAd+vmjQ69r3O4YJxAaOZc/NntYEARBWRDH5vG9qzsv6O1vd4kKLP3AGguRp/A1JklWYmpfdVM=
Received: by 10.150.58.1 with SMTP id g1mr7487800yba.85.1212562013866;
        Tue, 03 Jun 2008 23:46:53 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Tue, 3 Jun 2008 23:46:53 -0700 (PDT)
In-Reply-To: <320075ff0806032340k9814a81g196e0417d42a3f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83749>

On Wed, Jun 4, 2008 at 12:40 PM, Nigel Magnay <nigel.magnay@gmail.com> wrote:
>>
>> But this shows one reason why I don't use Maven I think.  The
>> fact that we need a "java" directory to hold our java code.
>> What if another build system wants a different name?  Grumble.
>>
>
> You don't. Just set the appropriate config item in pom.xml
> (sourceDirectory possibly, but my memory isn't good this morning) and
> you can use 'src' as it is currently. src/main/java is just the
> default.

You are absolutely right in fact (your memory did not betray ;)) its
<project><build><sourceDirectory>.

>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
