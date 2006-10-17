From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:55:55 +0200
Message-ID: <200610171555.56778.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<4534C5CF.3000508@op5.se> <vpqlknf3wdz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 15:55:59 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpQE-00043b-QR
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 15:55:58 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZpQ4-0006a5-Tl; Tue, 17 Oct 2006 14:55:49 +0100
Received: from ug-out-1314.google.com ([66.249.92.173])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GZpPp-0006Zu-OM
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 14:55:33 +0100
Received: by ug-out-1314.google.com with SMTP id 36so939487ugg
	for <bazaar-ng@lists.canonical.com>;
	Tue, 17 Oct 2006 06:55:33 -0700 (PDT)
Received: by 10.67.97.18 with SMTP id z18mr9795468ugl;
	Tue, 17 Oct 2006 06:55:29 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
	by mx.google.com with ESMTP id 59sm187888ugf.2006.10.17.06.55.28;
	Tue, 17 Oct 2006 06:55:28 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpqlknf3wdz.fsf@ecrins.imag.fr>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29072>

Matthieu Moy wrote:
>> Side-note 2: Three really great things that have made work a lot
>> easier and more enjoyable since we changed from cvs to git and that
>> aren't mentioned in the comparison table:
> 
> Sure. And regarding this, hopufully, most modern VCS go in the same
> direction.
> 
> > * Dependency/history graph display tools á la qgit/gitk
> 
> http://bazaar-vcs.org/bzr-gtk
> http://samba.org/~jelmer/bzr/bzrk.png

Hmmm... most of the tools look similar. Git has gitk (Tcl/Tk, now in 
git.git repository), QGit (Qt), GitView (GTK+, in contrib/), 
git-browser (JavaScript, uses High Performance JavaScript Graphics 
Library by Walter Zorn, http://www.walterzorn.com, for graphics).

Tig (Text-mode Interface for Git, ncurses) also in it's git version has 
a kind of history graph using ascii-art.


That is very important tool to have for any SCM which allows (and 
encourages) nonlinear history development.
 
>> * Bisection tool for finding bug introduction revisions.
> 
> This took time to come in bzr, but that's the bisect plugin:
> 
> http://bazaar-vcs.org/PluginRegistry

Hmmm... I winder which SCM had it first.
 
>> * Tools for sending commits as emails.
> 
> (Surprisingly, I had added this in the table, but has been removed for
> some obscure reasons)

While email can be used to exchange patches (git-format-patch to 
generate patches, git-send-mail to send patches if you don't want to 
use ordinary email client, git-am to apply patches) it cannot be used 
to exchange all information (one cannot send for example tags, or merge 
commits).

It is very usefull tool to have for "accidental" developer. You don't 
have to have constant on-line presence in the form of web server or git 
server somewhere for sending pull requests (although http://repo.or.cz 
public git repo hosting can help with that), you don't have to have 
access (ssh perhaps limited, or WebDAV one) to do push to somebody else 
repository, you can just send email to some mailing list.

BTW. git can provide binary patch for binary files (e.g. adding favicon 
for gitweb in git.git).


Other often and not-so-often used tools include:
 * git-rerere - Reuse recorded resolve (of merge conflicts)
 * reflog - Records where was given branch at given time (no UI yet)
 * git-diff -S'text' aka. pickaxe - find commits which added or removed
   given 'text'; and other revision limiters
