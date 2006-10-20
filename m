From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 15:20:42 +0200
Message-ID: <200610201520.42799.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<eha9rq$5t7$2@sea.gmane.org> <vpqslhjyxlz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 15:21:07 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauIu-0001NI-U5
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 15:20:53 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GauIt-0007oV-Tl; Fri, 20 Oct 2006 14:20:52 +0100
Received: from ug-out-1314.google.com ([66.249.92.175])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GauIh-0007je-SM
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 14:20:39 +0100
Received: by ug-out-1314.google.com with SMTP id 36so669075ugg
	for <bazaar-ng@lists.canonical.com>;
	Fri, 20 Oct 2006 06:20:39 -0700 (PDT)
Received: by 10.67.24.13 with SMTP id b13mr1819630ugj;
	Fri, 20 Oct 2006 06:20:39 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id o1sm144876uge.2006.10.20.06.20.38;
	Fri, 20 Oct 2006 06:20:39 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpqslhjyxlz.fsf@ecrins.imag.fr>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29461>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> If you're interested, it's called "Bugs Everywhere" and it's available here:
> >> http://panoramicfeedback.com/opensource/
> >> 
> >> New VCS backends are welcome :-D
> >
> > While SCM can (and should be usually) distributed, I think that bugtracker
> > has to be centralized.
> 
> Well, indeed, I think bug _reporting_ should be somehow centralized,
> while bug _fixing_ can be decentralized: You fix a bug, you mark it as
> fixed, and then the main branch gets the information that the bug is
> fixed when the bugfix is merged.

But you don't need much infrastructure for branch fixing. Fix it in
repository, and write bug number (you have to have centralized bugtracker
for numbers) or bug identifier in commit message. You write (or post-commit
hook writes) in bugtracker that bug was fixed in commit <commit-id>.
You tell mainline to pull from you. That's all.
