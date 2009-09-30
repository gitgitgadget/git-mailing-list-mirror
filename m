From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Wed, 30 Sep 2009 19:51:02 +0000 (GMT)
Message-ID: <287437.36328.qm@web27806.mail.ukl.yahoo.com>
References: <2c6b72b30909280546l62a6ef9cm21112ca071cdef4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, spearce@spearce.org,
	Jason van Zyl <jvanzyl@sonatype.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt5Ci-0001s2-0K
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbZI3TvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 15:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZI3TvB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 15:51:01 -0400
Received: from web27806.mail.ukl.yahoo.com ([217.146.182.11]:44246 "HELO
	web27806.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752012AbZI3TvA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 15:51:00 -0400
Received: (qmail 37227 invoked by uid 60001); 30 Sep 2009 19:51:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1254340263; bh=0VA/iFLyo53DlUHrA3bO2/xaEQd0oOZKLmK3rHi5vYM=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=EkEJd+JAfwl21fVGwnZQRt6Qo/UTJxouRrXvMS+6I6fl1H+UULvSfZL++w6GxhxFKCDbsgLby5gdWf1Tvyr1jNSP0XvVRdYxjf819lX7Vf07MDmT1DPpC83QD/yrmm0tFAXHfygpQAelto3tYKSdnz8Frnksbxi+g4pctnXZer4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=JvHFyYqzCoNYuGORi+Rr8rzvOGoS/99u7ppaDn2K4tZ2LJnuMmtE3GKhrPW/IyWjBytUkPADErBM7mWSjwAkvvRzPFXuO+0cxuLJVFIvLj+LbS6z9ZRaK9Ffa5BtakRIf1w6a7U4m8AOKiBL5dtgaNtqtwkygc7zD63dLuINGwM=;
X-YMail-OSG: 3bppuRcVM1kCmHdFED7NhWOmD1Nco8qt8wvfgh4baUQuc2Ht2yfdGO48i4SgGenfoJLdrCDWmWOMlAhoobHMPZAn9F8jU_e_pNFvIIAhH.DJO4MG3hUvFG1bexwQIVoj_dEPdB5.IOlUTqaJG2I5t49raaCmoqUxCYYbVMbmt4Sfy7adEakYQLMuRR8W_prkNc4cTguAbqWvZP7XczUQEz2s06xruezs4UT08RAFOcps3uphuNZMnTxnW.FSRZDCQo9TeQuAZUVwavhfuAY4UEL3LQg1bUSE9L04vwcBXrKAu98kNDWl.tvircMHYNb9eiHhhBrqLhuEec.R4mDpQv7eQjr0KY.1e3Moj3e2Vg--
Received: from [62.178.39.60] by web27806.mail.ukl.yahoo.com via HTTP; Wed, 30 Sep 2009 19:51:02 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <2c6b72b30909280546l62a6ef9cm21112ca071cdef4c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129352>

Hi Jonas!

answers inside

LieGrue,
strub

--- On Mon, 9/28/09, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:

> From: Jonas Fonseca <jonas.fonseca@gmail.com>
> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>, git@vger.kernel.org, spearce@spearce.org, "Jason van Zyl" <jvanzyl@sonatype.com>
> Date: Monday, September 28, 2009, 2:46 PM
> On Sat, Sep 26, 2009 at 15:50, Mark
> Struberg <struberg@yahoo.de>
> wrote:
> > Hi Robin!
> >
> > a) Actually git-format-patch only created 0001-0009 so
> there is no 0/9.
> 
> For larger patch series, it is good practice (at least on
> git@vger) to
> provide a "cover letter" (see git-format-patch
> --cover-letter) to give
> reviewers of the patch series an idea of what code is
> touched and for
> you to give additional information, such as the state of
> the patch
> series.

txs 4 pointing this out.

> 
> > b) 2/9 is the actual directory structure moving. I
> received it, but since it is pretty large (330k already with
> -M -l0) it might got filtered out?
> > If so then may I ask you to please fetch it from http://github.com/sonatype/JGit branch 'mavenize'? It
> has the same content I sent to the list.
> 
> Some general notes on the patch series. First, I am glad
> you posted it
> to have something to discuss and as I have stated in a
> private mail I
> am glad you are doing this. However, I also think it needs
> a lot more
> polish before being integrated.
> 
> While I understand that you want to credit Jason for doing
> the initial
> probe into fully mavenizing JGit, I now think it is wrong
> to base the
> patch series on his patch. My first impression is that it
> actually
> removes features (by not keeping the JGit specific
> settings), which
> you then try to amend later in the patch series.

I'm not sure what JGit specific settings you speak about?


> In terms of making the patch series more manageable for
> you, I think
> the best approach is to start with the patches not relevant
> to the
> mavenizing (renaming PathSuffixTestCase). 

In fact the fix of the PathSuffixTestCase came a few days later after I found the reason why I miss a few tests. This should be fixed in the current master anyway and has not so much todo with the mavenization itself.


> After this comespatches
> which only touch pom.xml files. For example, move
> jgit-maven/jgit/pom.xml to the top-level pom.xml, extract
> relevant
> pieces to org.spearce.jgit/pom.xml and
> org.spearce.jgit.test/pom.xml,
> improving the pom.xml`s by adding checkstyle/<scm>
> integration, and
> mavenizing org.spearce.jgit.pgm/. The final and most
> invasive parts
> (renaming/(re)moving code/eclipse files etc) should come
> last!

I had the following in mind: every single commit should be compileable and working. So it's not easily manageable to move the directory structure in one patch and apply all the changes into the poms in another commit.
We could for sure squash the later few commits, but I didn't liked to rebase and push since there have been a few forks of the mavenize branch and I hoped I could pull back a few commits from others and later do a rebase -i.

 
> Taking this approach Robin and Spearce can start
> integrating initial
> patces and we can all start testing the "mavenization"
> sooner rather
> than after deciding how to rename things and whether or not
> to remove
> certain files.
> 
> The above is a proposal and if you and other agree that it
> is the
> right approach _and_ you do not feel you have the time
> necessary to
> realize it, I am willing to work on it.

Any help is always welcome :)



      
