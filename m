From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Wed, 13 Feb 2013 22:42:07 +0100
Message-ID: <511C08AF.7090502@alum.mit.edu>
References: <5104E738.602@alum.mit.edu> <vpqtxpgb6ue.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Chris Hiestand <chiestand@salk.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 13 22:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5k68-0008A7-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 22:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908Ab3BMVmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 16:42:13 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:59403 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934131Ab3BMVmM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2013 16:42:12 -0500
X-AuditID: 1207440f-b7f276d0000008b2-1c-511c08b3e0e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 27.6B.02226.3B80C115; Wed, 13 Feb 2013 16:42:11 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1DLg8UC016764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Feb 2013 16:42:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <vpqtxpgb6ue.fsf@grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsUixO6iqLuZQybQ4PcfTYvjT6+zWKx9dofJ
	Yvv2LkaLrivdTBYNvVeYLS59Xs9q0fikyGL14zvsDhweO2fdZfeY+OU4q8fFS8oeN653M3p8
	3iTnceDyY7YAtihum6TEkrLgzPQ8fbsE7oyfP9pYC9ZrVrx7/J6tgXGufBcjJ4eEgInEyaZb
	TBC2mMSFe+vZuhi5OIQELjNKNPcfYQRJCAkcZ5I41JHTxcjBwSugLdHxRAIkzCKgKtH25zYL
	iM0moCuxqKcZbI6oQJhE7+tzYK28AoISJ2c+YQFpFRHQl/g5GWw8s8BPJokt2x6xgdQIC3hK
	LLx+hBVilafEgqerwOZwCuhJ3Nx7DWwOs4COxLu+B8wQtrzE9rdzmCcwCsxCsmIWkrJZSMoW
	MDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAiJA/4djF3rZQ4xCnAwKvHw
	Vv+RDhRiTSwrrsw9xCjJwaQkyjuFVSZQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvjf9A5bwp
	iZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd6D7EBDBYtS01Mr0jJzShDS
	TBycIMO5pESKU/NSUosSS0sy4kFxGl8MjFSQFA/Q3tcg7bzFBYm5QFGI1lOMxhz7n7Q/Z+TY
	/htICrHk5eelSonz2rIBlQqAlGaU5sEtgiXAV4ziQH8L874DGcgDTJ5w814BrWICWsW4Vgpk
	VUkiQkqqgXH+1F++aanhDyb77OF26PL9d/XRdhXpmu83P3ZeTq2ekhWiPGHim++N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216289>

On 02/13/2013 03:56 PM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> A while ago, I submitted an RFC for adding a new email notification
>> script to "contrib" [1].  The reaction seemed favorable and it was
>> suggested that the new script should replace post-receive-email rather
>> than be added separately, ideally with some kind of migration support.
> 
> I think replacing the old post-receive-email is a sane goal in the long
> run, but a good first step would be to have git-multimail merged in
> contrib, and start considering the old script as deprecated (keeping the
> old script doesn't harm IMHO, it's a one-file, 3 commits/year script,
> not really a maintainance burden).
> 
> I started playing with git-multimail. In short, I do like it but had to
> fight a bit with python to get it to work, and couldn't get it to do
> exactly what I expect. Pull request attached :-).

Thanks very much for your feedback and patches.

> Installation troubles:
> 
> I had an old python installation (Red Hat package, and I'm not root),
> that did not include the email.utils package, so I couldn't use my
> system's python. I found no indication about python version in README,
> so I installed the latest python by hand, just to find out that
> git-multimail wasn't compatible with Python 3.x. 2to3 can fix
> automatically a number of 3.x compatibility issues, but not all of them
> so I gave up and installed Python 2.7.

What version of Python was it that caused problems?  I just discovered
that the script wouldn't have worked with Python 2.4, where
"email.utils" used to be called "email.Utils".  But I pushed a fix to
GitHub:

    ddb1796660 Accommodate older versions of Python's email module.

With this change, I think that git-multimail will work with any version
of Python 2.4 <= x < 3.0.  So if your original problem was with Python
2.4, maybe you could try the new version and see if it works with that
interpreter.

> I think adding a short "dependencies" section in the README (or in an
> INSTALL file) saying which Python version works could save new users the
> trouble (I see the sheebang inside the scripts says python2 but since I
> couldn't use my system's python and called
> "path/to/python git_multimail.py", this didn't help).

Yes, I'm working on a "Requirements" section with that information and
more.  I'd like to list a minimum git version too, but it would be quite
a bit of work to figure out when each command and each option was added.
 It would be helpful if anybody who has used the script with an old
version of git lets me know whether they were successful or not.

> Making the script
> portable with python 2 and 3 would be awesome ;-).

Agreed, but I doubt I will be able to get to it very soon.

> Missing feature:
> 
> git-multimail can send a summary for each push, with the "git log --oneline"
> of the new revisions, and then 1 mail per patch with the complete log
> and the patch.
> 
> I'd like to have the intermediate: allow the summary email to include
> the complete log (not just --oneline). My colleagues already think they
> receive too many emails so I don't think they'd like the "one email per
> commit" way, but the 1 line summary is really short OTOH.
> 
> I wrote a quick and hopefully not-too-dirty implementation of it,
> there's a pull request here:
> 
> https://github.com/mhagger/git-multimail/pull/6
> 
> essentially, it boils down to:
> 
> @@ -835,6 +837,17 @@ class ReferenceChange(Change):
>                  for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLATE):
>                      yield line
>  
> +            if adds and self.showlog:
> +                yield '\n'
> +                yield 'Detailed log of added commits:\n\n'
> +                for line in read_lines(
> +                        ['git', 'log']
> +                        + self.logopts
> +                        + ['%s..%s' % (self.old.commit, self.new.commit,)],
> +                        keepends=True,
> +                        ):
> +                    yield line
> +
>              # The diffstat is shown from the old revision to the new
>              # revision.  This is to show the truth of what happened in
>              # this change.  There's no point showing the stat from the
> 

Thanks for the patch.  I like the idea, but I think the implementation
is incorrect.  Your code will not only list new commits but will also
list commits that were already in the repository on another branch
(e.g., if an existing feature branch is merged into master, all of the
commits on the feature branch will be listed).  (Or was that your
intention?)  But even worse, it will fail to list commits that were
added at the same time that a branch was created (e.g., if I create a
feature branch with a number of commits on it and then push it for the
first time).

Probably the Push object has to negotiate with its constituent
ReferenceChange objects to figure out which one is responsible for
summarizing each of the commits newly added by the push (i.e., the ones
returned by push.get_new_commits(None)).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
