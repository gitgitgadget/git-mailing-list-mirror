From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] JGit mavenization done right
Date: Wed, 20 Aug 2008 08:39:33 +0600
Message-ID: <7bfdc29a0808191939u2a060883o6a0047dc2caaa4fb@mail.gmail.com>
References: <7bfdc29a0808162152y4329303dte8f82bfea646180d@mail.gmail.com>
	 <7bfdc29a0808172333g1cbe2102n6e76ae98a1943411@mail.gmail.com>
	 <20080819144424.GC20947@spearce.org>
	 <200808192152.55267.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 04:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdfv-0007A7-Q7
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYHTCjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYHTCjh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:39:37 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49932 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYHTCjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:39:35 -0400
Received: by gxk9 with SMTP id 9so6051092gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e7kSdrZC3uzYL9FRa9V+Ev/XiFfkf46dJDAjkpDL7mo=;
        b=A4+bzsMwz7ZdF8r3DragW9L7JXQsciW3nr6ZASmM/+0fMU6XOn56BQ6aPMbDXdQpQ8
         ie0z45ObbxkzaNjXwHfWcvhAQMA0e9mBYea15iK/vsA00JEjIvxTZUXtmxqSXmaEM3Xe
         edln33wTKuuX3nhGEUoPTJ2lt72o1FeqOB/18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H4oBIQGme4wY01bl7bsnzGKuSI0ZB1PBQRnyQojU9sQWnHN5cO2EvObPOhx6pjl6JD
         Yyq2hNHeqdm+5XL7anzw8L2r8+LRryFXWVj2GO/oAS0QKQAwMM3CUWGriFSRrm3kDg13
         TwJ2bw8amcp60vJPdPaC1FB/H71Zf6iQpJQO8=
Received: by 10.150.150.3 with SMTP id x3mr13021139ybd.110.1219199974098;
        Tue, 19 Aug 2008 19:39:34 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Tue, 19 Aug 2008 19:39:33 -0700 (PDT)
In-Reply-To: <200808192152.55267.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92953>

On Wed, Aug 20, 2008 at 1:52 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 19 augusti 2008 16.44.24 skrev Shawn O. Pearce:
>> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> > On Mon, Aug 18, 2008 at 11:55 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > > Imran M Yousuf <imyousuf@gmail.com> wrote:
>> > >> I would like to request you all to test out JGit from
>> > >> http://repo.or.cz/w/egit/imyousuf.git. Please checkout the branch
>> > >> 'unified_tst_rsrc' and try to build it with both maven and Eclipse
>> > >> (i.e. as was built earlier)
>> >
>> > Thanks, it would nice to know whether it works in the original build
>> > process or not :).
>>
>> Well, it did break it in Eclipse:
>>
>> $ git diff-tree --abbrev -r -M --diff-filter=D orcz-pub/master HEAD
>> :100644 000000 9d7d138... 0000000... D  org.spearce.jgit.test/.gitignore
>> :100644 000000 987d6be... 0000000... D  org.spearce.jgit.test/.project
>> :100644 000000 8bfa5f1... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
>> :100644 000000 fce94cf... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.ui.prefs
>> :100644 000000 304e861... 0000000... D  org.spearce.jgit/.classpath
>> :100644 000000 ba077a4... 0000000... D  org.spearce.jgit/.gitignore
>> :100644 000000 7d38455... 0000000... D  org.spearce.jgit/.project
>> :100644 000000 709a440... 0000000... D  org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
>>
>> Removing this stuff was not so good.  The Eclipse projects are
>> busted and can't be used anymore.  We need them back.
>>
>> The make_jgit.sh however seems to produce a valid JAR.  Given the
>> file-level differences I didn't expect it to fail.
>>
>> Also, I wonder if JGitTestUtil is better handled by placing the
>> method in RepositoryTestCase and making sure everyone subclasses
>> that if they need a test resource file?  I'm fairly certain they
>> already do, and its a lot easier to invoke a method you inherited
>> than one in another class.  (Well, easier for the guy writing the
>> test case anyway, Java obviously doesn't care either way.)

In a true OOP sense a util class seemed a more valid approach to me. I
usually prefer to inherit staffs that are actually part of the object,
what I can do is have a base class method invoking the util, that will
not harm me :).

>>
>> If we are going to take this in upstream I'd like a flattened/cleaned
>> up history.  Being able to bisect the misstep of using symlinks
>> (the old Maven approach) isn't very valuable in the long-term view
>> of the history.
>>
>> Robin, any thoughts?
>
> Right, I'd also like to see that cleaned up approch in patch form. Cleaning up
> helps when preparing for review because one usually find bad stuff during
> that process.

I agree with the cleaned up approach I will redo it afresh by tonight
or day after tomorrow and create patches and resubmit it.

Thanks,

Imran

>
> -- robin
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
