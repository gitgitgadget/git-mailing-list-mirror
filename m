From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 22:34:06 +0200
Message-ID: <bd6139dc0807201334l446f6da2i36178a1e1063a3bf@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
	 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
	 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
	 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
	 <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
	 <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfca-0008TU-IE
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYGTUeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYGTUeI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:34:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:34775 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYGTUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:34:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1251245wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cyX6YjhrvW8ZxYHclfEEs69QaA4sQLN7KQtuWGakuXw=;
        b=VfM0C1EDZK/TjSEpwoCqENlP+IbQAJ4grpENoZppyi6zIf2T4PDTdh3mTEyK8JKN32
         vakYaFIvR+heTwi0wwy2GeIZvdiOYQXEBlmFC09UtUdzHdwmn+ZAJq5M77lFYBA5K63K
         GjTU8j47FYqCtUeSgXIje2Aws2MUUSAyI/rBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=BNrAbbT9zxXIZcMCjULqR55L3mn0vsW53oN6/ZmLZpbh87AbelOoWQkt4t1jGFrgka
         amDl3TfE4jXDxEBcMuqtuYeVXz0h6Gh4XgeaWievq6r+IflQXaQVF0aLJaNRNicuByDV
         ft83/6q+3P14TWIiKASUPyQ6dYP/6/FQS1644=
Received: by 10.142.177.7 with SMTP id z7mr1018623wfe.88.1216586046439;
        Sun, 20 Jul 2008 13:34:06 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 13:34:06 -0700 (PDT)
In-Reply-To: <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89227>

On Sun, Jul 20, 2008 at 2:45 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Lastly, I point out that when I started with git, it became much
> clearer when I began reading "git add" as "git stage". I think my
> first alias was "staged => diff --cached". But I am someone who likes
> to learn how the things I use work early on.

I love it, and the great thing is that auto-complete works on it too!
"git diff --cached" 17 keystrokes
"git stag" 8 keystrokes
That's a 9 keystrokes improvement!


-- 
Cheers,

Sverre Rabbelier
