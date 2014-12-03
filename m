From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Our cumbersome mailing list workflow
Date: Wed, 03 Dec 2014 18:28:08 +0100
Message-ID: <547F4828.3000801@web.de>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu>	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>	<5473CD28.5020405@alum.mit.edu>	<54776367.1010104@web.de>	<20141127225334.GA29203@dcvr.yhbt.net>	<547895F1.1010307@alum.mit.edu>	<xmqqh9xgrssc.fsf@gitster.dls.corp.google.com> <CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDj0-00040i-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbaLCR2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:28:22 -0500
Received: from mout.web.de ([212.227.17.11]:59428 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaLCR2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:28:21 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MX0Q4-1XQJGE07gi-00VuuC; Wed, 03 Dec 2014 18:28:14
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
X-Provags-ID: V03:K0:4e8qdqdFOu/dkxQsGTKLNtxLEn2LXUykshIODpWfhDWsqUZVHao
 us/kDyXBml7iNwdJcPm+CsmVih3M6zR+Le4J/LyDgsYYncv5c7Dv6X2Nrg2qdaLaEkVvTQz
 N1lRR7UT8XSAnLYBynrbsIFrvNLR8iwV+pei51YpKw9RdbgheS27VB4SkfXgr/SBuofoD/b
 eovLWFl7tulHuDfQzJxrQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260667>

On 2014-12-03 03.20, Stefan Beller wrote:
> On Sun, Nov 30, 2014 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> It seems like a few desirable features are being talked about here, and
>>> summarizing the discussion as "centralized" vs "decentralized" is too
>>> simplistic. What is really important?
>>>
>>> 1. Convenient and efficient, including for newcomers
>>> 2. Usable while offline
>>> 3. Usable in pure-text mode
>>> 4. Decentralized
>>>
>>> Something else?
> So when I started overtaking the ref log series by Ronnie,
> Ronnies main concern was missing reviewers time. So my idea was to
> make it as accessible as possible, so the reviewing party can use their
> time best. However here are a few points, I want to mention:
>
>  * Having send emails as well as uploaded it to Gerrit, I either needed
>    a ChangeId (Gerrit strictly requires them to track inter-patch
> diffs), and the
>    mailing list here strictly avoids them, so I was told.
>    Ok, that's my problem as I wasn't following the actual procedure of the
>    Git development model (mailing list only).
>  * That's why I stopped uploads to Gerrit, so I do not need to care about the
>    ChangeIds any more. I am not sure if that improved the quality of my patches
>    though.
>  * I seem to not have found the right workflow with the mailing list yet, as I
>    personally find copying around the inter-patch changelog very inconvenient.
>    Most of the regulars here just need fewer iterations, so I can understand,
>    that you find it less annoying. Hopefully I'll also get used to the
> nit-picky things
>    and will require less review iterations in the future.
>    How are non-regulars/newcomers, who supposingly need more iterations on
>    a patch,  supposed to handle the inter patch change log conveniently?
>    I tried to keep the inter patch changelog be part of the commit message and
>    then just before sending the email, I'd move it the non-permanent section of
>    the email.
>  * Editing patches as text files is hard/annoying.
Not sure if I understand. Editing text files isn't that hard, we do it all the time.
>  I have setup git send-email,
>    and that works awesome, as I'd only need one command to send off a series.
>    Having a step in between makes it more error-prone. So I do git format-patch
>    and then inject the inter patch change log, check to remove ChangeId and then
>    use git send-email.
How do you "inject the inter patch change log" ? Is that manually, or is it a script ?
>  And at that final manual step I realized I am
> far from being
>    perfect, so sometimes patches arrive on the mailing list, which are
> sub quality
>    in the sense, that there are leftovers, i.e. a ChangeId
>  * A possible feature, which just comes to my mind:
>    Would it make sense for format-patch to not just show the diff
> stats, but also
>    include, on which branch it applies? In git.git this is usually the
> origin/master
>    branch, but dealing with patch series, building on top of each other that may
>    be a good feature to have.
>

Thanks for the description (and everybody for the discussion)
In the hope that it may help, I can try to describe my work flow:
- Run a script to send the patch (this is a real example)
#################

SRCCOMMIT=119efe90bffee688a3c37d4358667
DSTCOMMIT=$(git log --oneline -n1 | awk '{print $1}')
VERSION="-v 1"

PATCHFILE=$( echo $0 | sed -e 's/\.sh$/.patch/')
GIT_TEST_LONG=t
export GIT_TEST_LONG
git am --abort || :
(  test -s $PATCHFILE || 
	git format-patch $VERSION -s --to=git@vger.kernel.org  --cc=tboegi@web.de  --cc=mhagger@alum.mit.edu --stdout $SRCCOMMIT..$DSTCOMMIT >$PATCHFILE ) &&
git checkout $SRCCOMMIT &&
git am <$PATCHFILE &&
cd t && cd .. && make &&
(cd t && ./t0001*.sh) &&
git imap-send <$PATCHFILE

#####################
The script formats a patch file (if that does not exist),
applies the patch on the source commit,
runs make and then the test cases to verify that the patch works.
(For bigger patches more tests or the whole test suite should be run,
for this very isolated work it OK to run a singe test)

Once everything is OK, the patch is stored both on disc and in the Drafts folder of the "email program".
(In your case you can use grep to remove the ChangedId or to check that it had been removed)

Now it is time to "tweak" the patch file with an editor:
Add what has been changed  since V1....
Save the patch file, run the script again to verify that the patch still applies and works and
put it into the Drafts folder of the mail program.

(That's why I abort the "git imap-send" in the first round
and press ^C when the password is asked)

Start the favorite email program
(Kmail works, or Thunderbird or 
 every other program that can send email in "plain text")

Have a final look at the patch in the email prgram
(remove the V1 from the header, change PATCH into PATCH/RFC).

Let the spell checker look at it, re-read once more.
If everything is OK, press the "send" button.

If I send out a V2 version, make a copy of the script, and call it doit2.sh,
change what needs to be changed.
We can enhance the script to push to a global repo, create a new branch just to
be sure we re-find our work...

I store all these scripts under a folder in my home directory,
each script has it's own directory, this for example is under
141119_check_file_mode_for_SAMBA/.
And if I am afraid that I don't know where it ended,
I can make a comment file here and notice that Junio picked it up here:
junio/tb/config-core-filemode-check-on-broken-fs
(And the remote junio is "git://github.com/gitster/git.git")

The good thing is that both the script and the patch file can be put
under version control.


I realized that re-checking the email which is rally send out to the list
is worth the time and effort.
Sometimes I keep it in the Drafts folder over night, and have
a new look with fresh eyes the next day.
