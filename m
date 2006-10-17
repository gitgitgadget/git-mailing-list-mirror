From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 17:27:44 -0400
Message-ID: <45354AD0.1020107@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 23:28:51 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZwUV-0007qH-B4
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 23:28:51 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZwUK-0005XF-3B; Tue, 17 Oct 2006 22:28:40 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <aaron.bentley@utoronto.ca>) id 1GZwUB-0005Wa-PH
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 22:28:34 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41]
	helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZwU1-0004P0-00; Tue, 17 Oct 2006 17:28:26 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610172301.27101.jnareb@gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29117>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
>>Ah, now I see what you mean, and the "graft" plugin mentioned by others
>>fills that role.  I've never used it, though.
> 
> 
> Very useful as a kind of poor-man's-Quilt (or StGit). You develop some
> feature step by step, commit by commit in your repository cooking it
> in topic branch. Then before sending it to mailing list or maintainer
> as a series of patches (using git-format-patch and git-send-email)
> you rebase it on top of current work (current state), to ensure that
> it would apply cleanly.

What is the bad side of using merge in this situation?

>>Interesting.  We don't do 'fast-forward' in that case.
> 
> 
> Fast-forward is a really good idea. Perhaps you could implement it,
> if it is not hidden under different name?

We support it as 'pull', but merge doesn't do it automatically, because
we'd rather have merge behave the same all the time, and because 'pull'
throws away your local commit ordering.

>>So it sounds to me like git is extensible, though not as thoroughly as bzr.
> 
> 
> I think having good API for C, shell and Perl (and to lesser extent for any
> scripting language) means that it is extensible more.

I guess it's a value judgement on which is more important to extensibility:

Git has more language support.

Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
and more.  Because Python supports monkey-patching, a plugin can change
absolutely anything.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNUrP0F+nu1YWqI0RAizXAJ0Wnf2ZoIRpaba3mX2L4pN9XcWDPQCePtg/
G/W6Oxm+kd8SzhGEEfLAxL8=
=VqC7
-----END PGP SIGNATURE-----
