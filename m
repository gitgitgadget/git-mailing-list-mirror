From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Mon, 20 May 2013 17:18:31 +0700
Message-ID: <CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 12:19:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeNBM-0002yD-E2
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 12:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab3ETKTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 06:19:03 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:52074 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab3ETKTC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 06:19:02 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo10so5357757obc.20
        for <git@vger.kernel.org>; Mon, 20 May 2013 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+Dz+mDmMCj3o9+ciWQdwF0x8Cek0mzGHOKG+D3tI5j8=;
        b=mFLWK6PHVAgsgkZtbTSYFGqy/Qh2UC3dDJ5mqwnf6NZWwpCfyptJQ8JoSRI2ojYbqk
         AqMFP9cwWiF4c724LzVrfRT+IzRgzjkrjHgpbQAh+HSNbstQIBkkvpH/sjTzL/Zj7Omr
         YuEbxgPX7jrCIRa7QuivDsnaq24TdXM03qaXNBKDfxKctMHNr0kqZ3m7MzrY1UY5O1q0
         OMMIbqcAFRoEoprWQPSPipZrzRA/AmNAeDqSwyKFhsIJX1Fj6daRI/ui8UFvcJoCsRKU
         INTH2GJtlyOXb8weW/lBvauStyHV6oz2zCWa/yInoyIKQKQ/lU4qc5G7jvcxeZAknZG2
         KSBg==
X-Received: by 10.60.150.146 with SMTP id ui18mr7970840oeb.101.1369045141812;
 Mon, 20 May 2013 03:19:01 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 20 May 2013 03:18:31 -0700 (PDT)
In-Reply-To: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224951>

On Thu, May 16, 2013 at 6:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/warn-ambiguous-object-name (2013-05-07) 1 commit
>  - get_sha1: improve ambiguity warning regarding SHA-1 and ref names
>
>  "git cmd <name>", when <name> happens to be a 40-hex string,
>  directly uses the 40-hex string as an object name, even if a ref
>  "refs/<some hierarchy>/<name>" exists.  This disambiguation order
>  is unlikely to change, but we should warn about the ambiguity just
>  like we warn when more than one refs/ hierachies share the same
>  name.
>
>  The message needs to be fixed up, as this is not "refname is
>  ambiguous".

hm.. how should the message be rephrased? ambiguity of 40-hex string
and a ref path?
--
Duy
