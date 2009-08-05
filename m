From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git index: how does it work?
Date: Wed, 5 Aug 2009 11:21:00 -0700
Message-ID: <fabb9a1e0908051121m6efafc02gd468a92784a73ecd@mail.gmail.com>
References: <loom.20090805T160528-69@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Shaun Cutts <shaun@cuttshome.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYl7Z-0002v2-4i
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbZHESVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbZHESVV
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:21:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:64970 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZHESVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:21:20 -0400
Received: by ewy10 with SMTP id 10so199228ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8Z3fDsLeg+ld4415lFJMqwn1bgUZeCizlcUZLlLfgbs=;
        b=jM3Qs+z0wkjrQc/pL7Qzv1pmSk8ieDbpkIN+CDYEh1rtdW9JMkzDe8klNsMlPRfuT3
         pE9+VriTej5NAInnUXfNLrAoKIVOGOS8rTR0ieOno7Hi8rAESonI3Dgia/pRNPOzMYPz
         eo7w+nZcGAKtR/kB7md/Ih9hNnL+08+P6jp/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ea178ZlCuqc+bxPBDvjt9UikqJbEyxkcliZbMr1u1fzbTTsEDM3lc/BUOOtWJjS0gs
         Vxs0Bt6DkvZxod2DMDDmTz6w15LI7rEW5Y3kz3V0SWspfnrhSQm3Ic1gGBH0YejUhU7V
         YnE/l0qTClxBaoctJa7IuaW+EY24o9WotUCdA=
Received: by 10.216.11.211 with SMTP id 61mr1874847wex.68.1249496480155; Wed, 
	05 Aug 2009 11:21:20 -0700 (PDT)
In-Reply-To: <loom.20090805T160528-69@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124941>

Heya,

On Wed, Aug 5, 2009 at 09:21, Shaun Cutts<shaun@cuttshome.net> wrote:
> PS I'm considering writing an extension to git where the "diff" understands the
> semantics of certain types of files: hunks wouldn't just be textual blobs but
> would try to represent a minimal change from one version to the next based on an
> edit distance, so that, e.g. changing the location of a function would be
> represented by a "move" edit, rather than two text changes.

This sounds very similar to what Daniel was discussing in "[PATCH 2/3
v3] Use an external program to implement fetching with curl git" [0],
if you're truly interested in doing this, please do keep me posted
(and I suspect Dscho might also be interested in being cc-ed) :).

[0] http://thread.gmane.org/gmane.comp.version-control.git/124503

-- 
Cheers,

Sverre Rabbelier
