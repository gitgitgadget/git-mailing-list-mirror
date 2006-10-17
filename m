From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:15:41 +0200
Message-ID: <200610171015.42320.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610170119.09066.jnareb@gmail.com>
	<45346290.6050300@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 10:30:26 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkLA-0004ql-Im
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 10:30:25 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZkKy-0004Wn-Fp; Tue, 17 Oct 2006 09:30:12 +0100
Received: from nf-out-0910.google.com ([64.233.182.186])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GZkKv-0004WJ-T3
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 09:30:10 +0100
Received: by nf-out-0910.google.com with SMTP id l37so228671nfc
	for <bazaar-ng@lists.canonical.com>;
	Tue, 17 Oct 2006 01:30:09 -0700 (PDT)
Received: by 10.49.10.3 with SMTP id n3mr1136497nfi;
	Tue, 17 Oct 2006 01:30:08 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
	by mx.google.com with ESMTP id o45sm540709nfa.2006.10.17.01.30.07;
	Tue, 17 Oct 2006 01:30:08 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45346290.6050300@utoronto.ca>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29036>

Dnia wtorek 17. pa¼dziernika 2006 06:56, Aaron Bentley napisa³:
> Jakub Narebski wrote:
> > Well, <ref>~<n> means <n>-th _parent_ of a given ref, which for branches
> > (which constantly change) is a moving target.
> 
> Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
> positive numbers to refer to the number of commits that have been made
> since the branch was initialized.
> 
> > One cannot have universally valid revision numbers (even
> > only per branch) in distributed development. Subversion can do that only
> > because it is centralized SCM. Global numbering and distributed nature
> > doesn't mix... hence contents based sha1 as commit identifiers.
> 
> Sure.  Our UI approach is that unique identifiers can usefully be
> abstracted away with a combination of URL + number, in the vast majority
> of cases.
> 
> > But this doesn't matter much, because you can have really lightweight
> > tags in git (especially now with packed refs support). So you can have
> > the namespace you want.
> 
> The nice thing about revision numbers is that they're implicit-- no one
> needs to take any action to update them, and so you can always use them.
> 
> > I wonder if any SCM other than git has easy way to "rebase" a branch,
> > i.e. cut branch at branching point, and transplant it to the tip
> > of other branch. For example you work on 'xx/topic' topic branch,
> > and want to have changes in those branch but applied to current work,
> > not to the version some time ago when you have started working on
> > said feature.
> 
> If I understand correctly, in Bazaar, you'd just merge the current work
> into 'xx/topic'.
> 
> > What your comparison matrick lacks for example is if given SCM
> > saves information about branching point and merges, so you can
> > get where two branches diverged, and when one branch was merged into
> > another.
> 
> I'm not sure what you mean about divergence.  For example, Bazaar
> records the complete ancestry of each branch, and determining the point
> of divergence is as simple as finding the last common ancestor.  But are
> you considering only the initial divergence?  Or if the branches merge
> and then diverge again, would you consider that the point of divergence?
> 
> merge-point tracking is a prerequisite for Smart Merge, which does
> appear on our matrix.
> 
> > Plugins = API + detection ifrastructure + loading on demand.
> > Git has API, has a kind of detection ifrastructure (for commands and
> > merge strategies only), doesn't have loading on demand. You can
> > easily provide new commands (thanks to git wrapper) and new merge
> > strategies.
> 
> I'm not sure what you mean by API, unless you mean the commandline.  If
> that's what you mean, surely all unix commands are extensible in that
> regard.
> 
> Aaron
> 
