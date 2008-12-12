From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Clarifying "invalid tag signature file" error message from git
 filter-branch (and others)
Date: Fri, 12 Dec 2008 10:44:03 -0600
Message-ID: <pM7a12pzXF7_bo-ZbyAqPidB0DEgwMnL3L42vDjdMAOFi2m_ib8CBw@cipher.nrlssc.navy.mil>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com> <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil> <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com> <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil> <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com> <87zlj1hd0r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Youngman <jay@gnu.org>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBB9G-0001oC-8e
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903AbYLLQoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbYLLQoU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:44:20 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54242 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbYLLQoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:44:18 -0500
Received: by mail.nrlssc.navy.mil id mBCGi3de016439; Fri, 12 Dec 2008 10:44:03 -0600
In-Reply-To: <87zlj1hd0r.fsf@rho.meyering.net>
X-OriginalArrivalTime: 12 Dec 2008 16:44:03.0325 (UTC) FILETIME=[D73622D0:01C95C78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102914>

Jim Meyering wrote:
> "James Youngman" <jay@gnu.org> wrote:
>> On Thu, Dec 11, 2008 at 11:13 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:

>>> What tool was used to convert this repository to git? It should be corrected
>>> to produce valid annotated tags. Especially if it is a tool within git.
>> I don't know, Jim Meyering will know though, so I CC'ed him.
> 
> I used parsecvs, probably with git-master from the date of
> the initial conversion (check the archives for actual date).
> That was long enough ago that it was almost certainly before
> git-mktag learned to be more strict about its inputs.
> 
> James, since you're about to rewrite the history, you may want to
> start that process from a freshly-cvs-to-git-converted repository.
> 
> I'm not very happy about using cvsparse (considering it's not
> really being maintained, afaik), so if the git crowd
> can recommend something better, I'm all ears.

I've only used git-cvsimport. AFAIK it creates light-weight tags in
git rather than annotated tags.

It also uses an unmaintained tool: cvsps. There are some additional
patches in a git repository somewhere that fix a few known problems.

You could try that James.

-brandon
