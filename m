From: Stefan Beller <sbeller@google.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Tue, 2 Dec 2014 18:20:14 -0800
Message-ID: <CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
	<5473CD28.5020405@alum.mit.edu>
	<54776367.1010104@web.de>
	<20141127225334.GA29203@dcvr.yhbt.net>
	<547895F1.1010307@alum.mit.edu>
	<xmqqh9xgrssc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvzYK-0008AK-6W
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 03:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaLCCUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 21:20:20 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:49886 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLCCUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 21:20:15 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so11963304igj.16
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 18:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rar4yGSzSZhDNftnX2+kZMaonLg5wiBV196lYq1YAMI=;
        b=KtLEqdoNBNFd7IPEanc+JVi92JsVvC5iHL7qJUC4zBznZF9sG93IG8xvc+F0zmLT7O
         8v0hylYHEU5J4gp74ccfJNP2Xzbjg6otkSPOTCmTW0qGcPK2IMfkCOcB3GgDurwqnAA+
         nL+RJKAI59d3oyykX+SX89+PDDUAifEvkwNg9A69NmNzr9imisg53M6X8HTC20oa2md1
         KER1Hc0PCTCLu/2+vAM9yA7uuzHT7+eAXnI98ZMEHTmATsO17GVrKTA9eNmj01CTCTU0
         rvlkRec75Yr2/klxxztQ00wqc39Qp1e4hBP66VsdSSxkzJirq+wls2DYTD4XztQW3vbe
         dxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Rar4yGSzSZhDNftnX2+kZMaonLg5wiBV196lYq1YAMI=;
        b=LZdTurElt1WnDvOYybsAfCmpjz+DZPCsuooASArB9zjnrNFz7EtcYQUkFK44aQ43wG
         z1jB4E9CypUYdIP5H9efFheGAuyFdumMyTnisLt6PwZcbCdWA990Y9ylSuQTza7JIAYK
         FQKL5sNnqvYO7kkDwwymRcUJD2ywIM405gHYJP1c0DrDwr1VHkEapxUR2giD5jR+USoC
         9HWan2hiDydMiA+GFNALKzpev3Pal4d8NzWg6cEZDJYorg2VZjq+hlvO4j7roxp/sInn
         6CNJvfHSdBndjplX8ocNhAaB8kUUeqBcZxeuVFSWXP8pAvBPcZsl+3OioXz8NfxxDQZJ
         Yj+g==
X-Gm-Message-State: ALoCoQnUmt3wbx/tFgr7+wQbvP4MU9X8ekhZl3aLwW4JFQPXJiSgtvemMJVMio7H8TBu3A0zbiVM
X-Received: by 10.50.111.226 with SMTP id il2mr54380704igb.10.1417573214687;
 Tue, 02 Dec 2014 18:20:14 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Tue, 2 Dec 2014 18:20:14 -0800 (PST)
In-Reply-To: <xmqqh9xgrssc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260614>

On Sun, Nov 30, 2014 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> It seems like a few desirable features are being talked about here, and
>> summarizing the discussion as "centralized" vs "decentralized" is too
>> simplistic. What is really important?
>>
>> 1. Convenient and efficient, including for newcomers
>> 2. Usable while offline
>> 3. Usable in pure-text mode
>> 4. Decentralized
>>
>> Something else?
>

So when I started overtaking the ref log series by Ronnie,
Ronnies main concern was missing reviewers time. So my idea was to
make it as accessible as possible, so the reviewing party can use their
time best. However here are a few points, I want to mention:

 * Having send emails as well as uploaded it to Gerrit, I either needed
   a ChangeId (Gerrit strictly requires them to track inter-patch
diffs), and the
   mailing list here strictly avoids them, so I was told.
   Ok, that's my problem as I wasn't following the actual procedure of the
   Git development model (mailing list only).
 * That's why I stopped uploads to Gerrit, so I do not need to care about the
   ChangeIds any more. I am not sure if that improved the quality of my patches
   though.
 * I seem to not have found the right workflow with the mailing list yet, as I
   personally find copying around the inter-patch changelog very inconvenient.
   Most of the regulars here just need fewer iterations, so I can understand,
   that you find it less annoying. Hopefully I'll also get used to the
nit-picky things
   and will require less review iterations in the future.
   How are non-regulars/newcomers, who supposingly need more iterations on
   a patch,  supposed to handle the inter patch change log conveniently?
   I tried to keep the inter patch changelog be part of the commit message and
   then just before sending the email, I'd move it the non-permanent section of
   the email.
 * Editing patches as text files is hard/annoying. I have setup git send-email,
   and that works awesome, as I'd only need one command to send off a series.
   Having a step in between makes it more error-prone. So I do git format-patch
   and then inject the inter patch change log, check to remove ChangeId and then
   use git send-email. And at that final manual step I realized I am
far from being
   perfect, so sometimes patches arrive on the mailing list, which are
sub quality
   in the sense, that there are leftovers, i.e. a ChangeId
 * A possible feature, which just comes to my mind:
   Would it make sense for format-patch to not just show the diff
stats, but also
   include, on which branch it applies? In git.git this is usually the
origin/master
   branch, but dealing with patch series, building on top of each other that may
   be a good feature to have.

>
> When I had to view a large-ish series by Ronnie on Gerrit, it was
> fairly painful.  The interaction on an individual patch might be
> more convenient and efficient using a system like Gerrit than via
> e-mailed patch with reply messages, but as a vehicle to review a
> large series and see how the whole thing fits together, I did not
> find pages that made it usable (I am avoiding to say "I found it
> unusable", as that impression may be purely from that I couldn't
> find a more suitable pages that showed the same information in more
> usable form, i.e. user inexperience).

So you're liking the email workflow more. How do you do the final
formatting of an email, such as including the inter patch diff?


>
> Speaking of the "whole picture", I am hesitant to see us pushed into
> the "here is a central system (or here are federated systems) to
> handle only the patch reviews" direction; our changes result after
> discussing unrelated features, wishes, or bugs that happen outside
> of any specific patches with enough frequency, and that is why I
> prefer "everything in one place" aspect of the development based on
> the mailing list.  That is not to say that the "one place" has
> forever to be the mailing list, though.  But the tooling around an
> e-mail based workflow (e.g. marking threads as "worth revisiting"
> for later inspection, saving chosen messages into a mailbox and
> running "git am" on it) is already something I am used to.  Whatever
> system we might end up migrating to, the convenience it offers has
> to beat the convenience of existing workflow to be worth switching
> to, at least to me as a reviewer/contributor.

I do like the way as well to just mark emails unread when I need
to work on them later.

>
> As the maintainer, I am not worried too much.  As long as the
> mechanism can (1) reach "here is a series that is accepted by
> reviewers whose opinions are trusted" efficiently, and (2) allow
> me to queue the result without mistakes, I can go along with
> anything reasonable.
>
