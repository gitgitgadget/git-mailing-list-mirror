From: John Koleszar <john.koleszar@on2.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:04:55 -0400
Organization: On2 Technologies
Message-ID: <1245333895.30640.28.camel@cp-jk-linux.corp.on2.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
	 <20090618063348.6117@nanako3.lavabit.com>
	 <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	 <87vdmuhs75.fsf@iki.fi>
	 <alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:05:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHIFQ-0001Uv-1q
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbZFROFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 10:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbZFROFb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:05:31 -0400
Received: from mail.on2.com ([66.162.65.131]:59906 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751552AbZFROFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 10:05:31 -0400
In-Reply-To: <alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
X-Mailer: Evolution 2.24.5 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121844>

On Thu, 2009-06-18 at 04:29 -0400, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 18 Jun 2009, Teemu Likonen wrote:
> 
> > On 2009-06-18 10:06 (+0200), Johannes Schindelin wrote:
> > 
> > > I'd really rather stay with "fixup". And as I use single-letter
> > > commands quite often, I'd also rather stay away from that magic "!".
> > > And by "magic" I really mean that: people will not find that magic
> > > intuitive at all.
> > 
> > I don't know about people but I do find "!" intuitive. It is squash
> > after all so I like the idea of using small modifier character.
> 
> Mhm.
> 
> So let's just interpret the "!" in the most common meaning, namely to add 
> an imperative.  Then it means "yes, I do want to squash".  Not 
> "squash, but oh, BTW, I want to lose the second commit message 
> completely, and I do not want to edit the commit message either".
> 
> Really, I do not see how anybody could find this intuitive at all.  Maybe 
> after reading the manual, but kinda defeats the meaning of the word 
> "intuitive".

The imperative is actually the reason I picked that modifier, as in
"yes, I /really/ do want to squash. Don't ask me, just do it!" Something
akin to -f. I think it makes sense here, but not in the case someone
else mentioned of a commit message only edit. ("recommit" for that
case?) 

In any case, I think this non-interactive squash is orthagonal to being
able to automatically rearrange the commits by "squash to ...". I think
that's a cool idea, but I know that I often don't remember the text of
the commit I want to squash into. So in my case I prefer rearranging
manually and squashing non-interactively. If I planned ahead, I could
pick a prefix for each "class" of commit, and then "squash to prefix",
but I'd want to be able to edit the original commit to remove the
prefix. Sure, I could look at the log, but if I'm just writing a
nonsense message to remind myself where to squash to, I think it would
get in the way of my flow.
