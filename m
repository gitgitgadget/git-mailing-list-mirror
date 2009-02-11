From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 22:49:44 +0200
Message-ID: <8e04b5820902111249n5fb87ff1r3d030b008fec0c28@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
	 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
	 <20090211191445.GU30949@spearce.org>
	 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
	 <20090211192245.GA28832@coredump.intra.peff.net>
	 <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
	 <20090211194218.GA28927@coredump.intra.peff.net>
	 <8e04b5820902111203t344881f6g31f25cfbff5fd822@mail.gmail.com>
	 <7vvdrgd8pb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXM38-0006a0-Tq
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbZBKUtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZBKUtr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:49:47 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38831 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbZBKUtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:49:46 -0500
Received: by bwz5 with SMTP id 5so571543bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RXV9r71dXAkzV5QrtGMABoHEkTD9vlQHSVZhXTxPbNE=;
        b=p1s7bvxeP84SpA8lW8UD7kx71YX94b5ooLcdTPJHDPEix3IkU8IbZc5nv99DftyvXU
         t73LRfyOMBgnyhkBakzrex9b7Eup9ANuRnReLqli2JU/IvNws8JZqdHeUwB7zZMAosLX
         4zDmWowwx25yVylgkuVPYSDR5WEnyb+DUHSTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mggSifv/HKO7574RsvilhNM6HIa3q286uKO1eRH0yKk71YeDGPHBavIaj0GQtOALy/
         idPwhTwVQwtn/D93mWISZSPq25wgud143gMejy6ezFKmoyLyv8QYJac6+ch5DXfKmgJx
         Ut/JrKrgDxDxInf+Uhj4zu0DokYtQPGdShRBg=
Received: by 10.181.193.15 with SMTP id v15mr24801bkp.7.1234385384164; Wed, 11 
	Feb 2009 12:49:44 -0800 (PST)
In-Reply-To: <7vvdrgd8pb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109525>

On Wed, Feb 11, 2009 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:
>
>>     I'll merge both Junio's and Jeff's emails into one... My answers bellow.
>>
>> On Wed, Feb 11, 2009 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:
>>>
>>>> On Wed, Feb 11, 2009 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>> And why isn't it in $HOME/bin/?
>>>>
>>>>     No, it is inside .git/bin folder.
>>>
>>> You are not answering my question.
>>>
>>> I questioned the sanity of putting the scripts in .git/bin/ per
>>> repository.  Why shouldn't a useful script like your "branch-import"
>>> available to _all_ your repositories, possibly taking customization per
>>> repository from repository's .git/config file, so that it does what is
>>> appropriate in each repository?
>> ...
>>     Both these solutions work fine, except one concern: when moving
>> the repository I would also want to move my scripts,...
>
> Define "moving the repository".  More often than not, people move their
> repositories with "git clone" than "tar cf - | tar xf -".
>
> No matter how you are moving it to a new location, you would want to have
> a working set of "regular environment" you normally work in.  Why aren't
> you moving/copying your $HOME/bin at the same time to get a more familiar
> and useful environment?  Viewed under this light, I think your "I move my
> repository to a new machine" is a made up example that is not interesting
> at all, if you ask me.
>
> There are additional security implications.  You can invite a victim to
> run "git diff" in your repository which runs your .git/bin/git-diff, for
> example.


    By moving the repository I mean moving it on another machine...
Let me give you an example...

    Thus (inspired by one of my current usages of Git) suppose I'm
working at a scientific project (let's assume algorithmic nature) and
after I succeed in having a working version of my algorithm, I decide
to test it on a better hardware with bigger workloads... For this I
make a tar of my repository, and un-tar it on the remote machine. (On
this remote machine, as I don't have administrative rights, I've
compiled by hand the latest version of git and put it somewhere on my
path. But it would have been nice if I would have had the latest git
version already installed...)

    (Looking even further, I could use such a procedure to distribute
my code to an entire cluster... Which I'm working to do right now...)

    Where do the repository-custom commands get into the scene? Well
let's suppose I also want to track the run-traces of my algorithm for
results reproduction / debugging purposes. But these files are big
text files that differ in many unimportant places, and thus I would
like `git diff` to show me only the meaning-full differences (by using
external diff feature)... Also the custom diff is not very simple (it
needs a couple sed / grep / other pre-processing), so I decide to
create a special command (like git-diff-traces) that I put inside the
bin folder... (Maybe I would like also some cleaning of unimportant
lines before committing...)

    (About the cluster thing, what about a command like
git-cluster-push... This could be reused...)

    Now as you can see, the special commands that handle my traces are
only valid for this particular algorithm, thus for this particular
repository...

    Now suppose I want to send a tar-ball of this repository to
another person, and I weren't using the special purpose bin dir, I
would also have to remember to send him the scripts that are in some
other place than the repository, and also he would have to remember to
put them into the PATH each time he wants to use them... So as you
see, a lot of manual labor...

    The simplest way (by using my patch) is to do the following:
    * either send a tar of the repository (that contains the bin) (of
course he needs the patched version of Git);
    * either tell him to clone the repository and run a simple command
like ./git-repo-initialize that would create the .git/bin folder and
symlink or copy the special scripts there...

    About the security issue, I don't see any, if we add the bin
folder at the end of the search path, or just after the official
installation path...

    I don't think that this feature is more unsafe than the hooks system...

    Ciprian Craciun.
