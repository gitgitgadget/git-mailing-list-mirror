From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 22:46:01 +0200
Message-ID: <bd6139dc0805201346g411c7d64i16d206953e595b38@mail.gmail.com>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org>
	 <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
	 <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
	 <20080520201722.GF29038@spearce.org>
	 <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com>
	 <20080520203153.GH29038@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Dirk_S=FCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 20 22:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYjl-0003TU-Q3
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbYETUqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759588AbYETUqF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:46:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:23350 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759084AbYETUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:46:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1911172wfd.4
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UkbWMK5v0KrojS9oLsO2FnOFvnw+3S0C0q4aMGloPY0=;
        b=VWFQsw9rTKHeudn6wwakjl1Gtd2NFHpaV4ySmMoGqT1A5NDynnv0x3usbfSOhbfHVWWPcq4qiszRZn7gGJYgF/QnKa29W3BRysR5yaogmLGcPVDbtzcmk3v8dhjXPWPNJxIE+OGwWhhuXZAbVqLRDFrHMAtzOvAz1Z7XH0YVGdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EtySNP8WdyrVdYzmbCW+Hy4naKvgSXmsnnW8tzEHO8pghcOr+6qH1T1niTGbb0e1FWdobzhvFZbDzUks70RiyWTiGSaMs1SHs/vXWkvJ1XDOti8/NpOv/Eb55n8roIai3Z85EvaonU2ouzOs8e+DrZ3zKJJjqcp4fgdSML83Vcs=
Received: by 10.142.162.5 with SMTP id k5mr3531927wfe.53.1211316361870;
        Tue, 20 May 2008 13:46:01 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 13:46:01 -0700 (PDT)
In-Reply-To: <20080520203153.GH29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82502>

On Tue, May 20, 2008 at 10:31 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Far from it.  Some users like git-gui for its ability to show
> the modified files, and let you stage/unstage individual hunks.
> Others like its ability to perform checkout+pull in one mouse
> click.  Many like to point at things with a rodent than to use
> the keyboard and enter (to them) isoteric commands.

Heh, I've never understood that, but I have a classmate that won't
touch anything that doesn't have a "shiney" GUI that he likes (that
is, he'll prefer the program with a "shiney" GUI even if there is one
without that has better features).

> Right now there are really only two git GUIs; git-gui and QGit.
> Each has its strengths.  Maybe this time next year we will have
> a 3rd; name yet to be determined but it would come out of the
> egit/jgit project as a stand-alone SWT/Java based Git UI.

Is it "shiney"? If you haven't already, look into applying a theme to
the app, the Substance LAF definitely looks "shiney"!

> Yes.  I'll send Junio a patch for Documentation/git-gui.txt and
> describe it as a debugging option, and also mention that the commands
> it displays aren't all meant to be invoked by mortals.

Sounds like a plan (maybe use "mere mortals" instead ;), it's more cool).

-- 
Cheers,

Sverre Rabbelier
