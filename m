From: Tassilo Horn <tassilo@member.fsf.org>
Subject: Re: vc in emacs problem with git
Date: Thu, 27 Aug 2009 19:45:50 +0200
Message-ID: <87hbvtxi9d.fsf@thinkpad.tsdh.de>
References: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
	<f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: help-gnu-emacs@gnu.org
X-From: help-gnu-emacs-bounces+geh-help-gnu-emacs=m.gmane.org@gnu.org Thu Aug 27 19:48:12 2009
Return-path: <help-gnu-emacs-bounces+geh-help-gnu-emacs=m.gmane.org@gnu.org>
Envelope-to: geh-help-gnu-emacs@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgj51-0007iJ-0C
	for geh-help-gnu-emacs@m.gmane.org; Thu, 27 Aug 2009 19:48:11 +0200
Received: from localhost ([127.0.0.1]:51886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Mgj50-0001Zt-1o
	for geh-help-gnu-emacs@m.gmane.org; Thu, 27 Aug 2009 13:48:10 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Mgj3K-0001Db-PT
	for help-gnu-emacs@gnu.org; Thu, 27 Aug 2009 13:46:26 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Mgj3G-0001Bj-2R
	for help-gnu-emacs@gnu.org; Thu, 27 Aug 2009 13:46:26 -0400
Received: from [199.232.76.173] (port=59235 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Mgj3F-0001BX-H7
	for help-gnu-emacs@gnu.org; Thu, 27 Aug 2009 13:46:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:38793)
	by monty-python.gnu.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60) (envelope-from <geh-help-gnu-emacs@m.gmane.org>)
	id 1Mgj3E-0006Y9-Sk
	for help-gnu-emacs@gnu.org; Thu, 27 Aug 2009 13:46:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Mgj34-00070C-PR
	for help-gnu-emacs@gnu.org; Thu, 27 Aug 2009 19:46:10 +0200
Received: from p54af269a.dip0.t-ipconnect.de ([84.175.38.154])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <help-gnu-emacs@gnu.org>; Thu, 27 Aug 2009 19:46:10 +0200
Received: from tassilo by p54af269a.dip0.t-ipconnect.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <help-gnu-emacs@gnu.org>; Thu, 27 Aug 2009 19:46:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.emacs.help
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54af269a.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Cancel-Lock: sha1:3GU6lK7u5DSzEqQVSBPnG0iTMPo=
X-detected-operating-system: by monty-python.gnu.org: GNU/Linux 2.6 (newer, 3)
X-BeenThere: help-gnu-emacs@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Users list for the GNU Emacs text editor <help-gnu-emacs.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/help-gnu-emacs>,
	<mailto:help-gnu-emacs-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/help-gnu-emacs>
List-Post: <mailto:help-gnu-emacs@gnu.org>
List-Help: <mailto:help-gnu-emacs-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/help-gnu-emacs>,
	<mailto:help-gnu-emacs-request@gnu.org?subject=subscribe>
Sender: help-gnu-emacs-bounces+geh-help-gnu-emacs=m.gmane.org@gnu.org
Errors-To: help-gnu-emacs-bounces+geh-help-gnu-emacs=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127181>

Rustom Mody <rustompmody@gmail.com> writes:

Hi Rustom,

> Just updating my own question:
> when I do a C-x v v (vc-next-action)
> which is supposed to be the most basic operation for checking in a file I get
>
>  Wrong type argument: stringp, nil
>
> So vc can be assumed to be a broken I guess?

Hm, please do `M-x toggle-debug-on-error', reproduce the error and poste
the backtrace.

Bye,
Tassilo
