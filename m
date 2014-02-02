From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 2 Feb 2014 18:00:37 +0700
Message-ID: <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
References: <87a9e92424.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:01:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9unZ-0004Nc-Lh
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbaBBLBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:01:09 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:48683 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaBBLBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:01:08 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so8634511qae.27
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y2nTEXQARaxShz9HowKXOoHod9JzZ+iBY8oPtN3Qh6o=;
        b=ueIy1pWwjN062mQOT7Bb2tythYo/sU5hRrtfyxzHxd6Jx3PqaQSk/jx4+6N8C7BUTc
         X0E7SdwLbtgl7HDBTlEjOyV35VrbmgFVfVmv5CWjtj9jtnEC+vXJ8e/ynqF2BPPbNogW
         Hdm+E6dqjp7IJWFVR9jDEaz4FEzusu9Y5wzsF24gvk+2iJ4dlQGsHZAdoSZENFZ2TPA7
         IiIiBLTDWaPuSTF698QFgOzEJEkoWtFv+XAadEQ6ku6FR6v0vZsmqNr9c3hjyqINc6iA
         +n9oGXGXpK+jAKm79+E6iEaN3k1JdRwdISji728zMGfkZGTpkqvox4d5x+w73c/sNpjf
         d8Rw==
X-Received: by 10.229.105.9 with SMTP id r9mr46866080qco.12.1391338867897;
 Sun, 02 Feb 2014 03:01:07 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 2 Feb 2014 03:00:37 -0800 (PST)
In-Reply-To: <87a9e92424.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241358>

On Sun, Feb 2, 2014 at 5:37 PM, David Kastrup <dak@gnu.org> wrote:
> in the context of an ongoing discussion on the Emacs developer list of
> converting the Bzr repository of Emacs, one question (with different
> approaches) is where to put the information regarding preexisting Bazaar
> revision numbers and bug tracker ids: those are not present in the
> current Git mirror.
>
> Putting them in the commit messages would require a full history
> rewrite, and if some are missed in the process, this cannot be fixed
> afterwards.

What do you need them for? Perhaps putting everything in a file, maybe
sorted by SHA-1, would suffice? It should not be too hard to write a
script to map bug tracker id to a commit id. The file is for past
commits only. New commits can contain these info in their messages.
-- 
Duy
