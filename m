From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:01:50 -0400
Message-ID: <453536AE.6060601@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <45349162.90001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 22:02:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZv8T-0007O4-Q0
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 22:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWJQUBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWJQUBz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 16:01:55 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:41665 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751185AbWJQUBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 16:01:54 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZv8J-0003Ah-00; Tue, 17 Oct 2006 16:01:51 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45349162.90001@op5.se>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29110>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Ericsson wrote:
> Aaron Bentley wrote:
>> Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
>> positive numbers to refer to the number of commits that have been made
>> since the branch was initialized.
>>
> 
> What do you do once a branch has been thrown away, or has had 20 other
> branches merged into it? Does the offset-number change for the revision
> then, or do you track branch-points explicitly?

We always track the number of parents since the initial commit in the
project.  Sorry, I don't think I said that clearly before.

>> If I understand correctly, in Bazaar, you'd just merge the current work
>> into 'xx/topic'.
>>
> 
> merge != rebase though, although they are indeed similar. Let's take the
> example of a 'master' branch and topic branch topicA. If you rebase
> topicA onto 'master', development will appear to have been serial.

Ah, now I see what you mean, and the "graft" plugin mentioned by others
fills that role.  I've never used it, though.

> If
> you instead merge them, it will either register as a real merge or, if
> the branch tip of 'master' is the branch start-point of topicA, it will
> result in a "fast-forward" where 'master' is just updated to the
> branch-tip of 'topicA'.

Interesting.  We don't do 'fast-forward' in that case.

>> I'm not sure what you mean by API, unless you mean the commandline.  If
>> that's what you mean, surely all unix commands are extensible in that
>> regard.
>>
> 
> I'm fairly certain he's talking about the API in the sense it's being
> talked about in every other application. Extensive work has been made to
> libify a lot of the git code, which means that most git commands are
> made up of less than 400 lines of C code, where roughly 80% of the code
> is command-specific (i.e., argument parsing and presentation).

Ah, okay.

So it sounds to me like git is extensible, though not as thoroughly as bzr.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNTat0F+nu1YWqI0RAn9aAJ9WzMrM72be+3SlwCpvJXQ/X2Y3nQCfeYk3
NTIJuZSze9URUaAsiO4Hu5o=
=9nvr
-----END PGP SIGNATURE-----
