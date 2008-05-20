From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 14:34:03 -0700
Message-ID: <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org>
 <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
 <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
 <20080520201722.GF29038@spearce.org>
 <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com>
 <20080520203153.GH29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 20 23:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyZUF-0004y2-Ox
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 23:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762355AbYETVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760790AbYETVeS
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:34:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760028AbYETVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:34:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 502766465;
	Tue, 20 May 2008 17:34:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1547A643E; Tue, 20 May 2008 17:34:07 -0400 (EDT)
In-Reply-To: <20080520203153.GH29038@spearce.org> (Shawn O. Pearce's message
 of "Tue, 20 May 2008 16:31:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D8A1CD6-26B4-11DD-8DD1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82505>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sverre Rabbelier <alturin@gmail.com> wrote:
>> >
>> > That is probably difficult.  Some of the code internally is more
>> > about stringing the right sequence of plumbing together than it
>> > is about a particular user action.  I think it would take a bit of
>> > work to make it do this, and I just don't see a reason to do it.
>> 
>> The reason would be to make the switch from using git-gui only to
>> using the commandline too... the again, it'd be cutting your own hand
>> (or is it "throat" in English...) to make that transition easier.
>
> I'm not worried about users leaving git-gui.  Hell, if git-gui
> was just git on training wheels and all git users left git-gui
> after a while for the command line that would be telling as it
> says the graphical interface is not desired.  Or that git-gui's
> interface is not well suited to the task.
>
> Far from it.  Some users like git-gui for its ability to show
> the modified files, and let you stage/unstage individual hunks.
> Others like its ability to perform checkout+pull in one mouse
> click.  Many like to point at things with a rodent than to use
> the keyboard and enter (to them) isoteric commands.
>
> Right now there are really only two git GUIs; git-gui and QGit.
> Each has its strengths.  Maybe this time next year we will have
> a 3rd; name yet to be determined but it would come out of the
> egit/jgit project as a stand-alone SWT/Java based Git UI.
>  
>> > CVS clients that show CVS commands can easily do so, because they
>> > are directly executing the commands they show you.  This is likely
>> > also true of SVN commands.  But git-gui on Git, that's a whole
>> > different animal.
>> 
>> Ah, I didn't realise git-gui does stuff that you can't really do
>> through the regular porcelain. In that case it would indeed be
>> impossible to print the regular porcelain commands. I think the
>> '--trace' option should be advertised as 'debugging option' so that
>> the user can see what is going on in the case something goes wrong
>> perhaps?
>
> Yes.  I'll send Junio a patch for Documentation/git-gui.txt and
> describe it as a debugging option, and also mention that the commands
> it displays aren't all meant to be invoked by mortals.

Probably --trace should be renamed to --debug then?
