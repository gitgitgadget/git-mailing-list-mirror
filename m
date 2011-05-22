From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Recovering from a bad object
Date: Sun, 22 May 2011 18:31:25 -0400
Message-ID: <BANLkTinPOYH_pJsFkbQHCb_H5GhyTn+xhg@mail.gmail.com>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
	<7vy61ywjpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 00:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOHBK-0004T1-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 00:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab1EVWb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 18:31:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48621 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab1EVWbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 18:31:25 -0400
Received: by iwn34 with SMTP id 34so4280119iwn.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n5p7X61iLPLMhpCHcyY3/hUaYdzjTxmQtN8lOG38s6M=;
        b=U5MxyGGqupHH8r32opqL8skqLzccXumk2p+7XaiJ1C607kNU9ihR0Vqo8JpeoIt0ni
         Ivzun89NIMo0UtlyLn6+hIhWmwZeqMlu6kbb3nuKZ0jpeywl+z5I6MiO7lyc2C4d/lUz
         wJsCTlLuqSfNyUxNCc0A8RdinE7Cpef6l6Edc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bsrmLqRfGxGDwCJroBfsv7oR6ouHLQz9b7n9MsxwZkdUaHIXOzZHlj99SD00D6rFlr
         pbr69S2zf2VuApQb7QmCmeNDWwYja3/MA0cBqgHx0JyxRzSD2xejj3jfgQhDoQF8tlHr
         EEn2oUYIEda6P9BJhMDQdiXPaFIDmGVJGkqDI=
Received: by 10.42.161.197 with SMTP id u5mr2809430icx.466.1306103485148; Sun,
 22 May 2011 15:31:25 -0700 (PDT)
Received: by 10.42.28.200 with HTTP; Sun, 22 May 2011 15:31:25 -0700 (PDT)
In-Reply-To: <7vy61ywjpa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174204>

Looks like the corrupt object is ok in the object store.

I checked out about 20 of the dangling objects. They all start off with...

commit aa96dc2459563fa362bc53597cb076d93bcc884a
Author: Jon Smirl <jonsmirl@gmail.com>
Date:   Sat Mar 19 13:30:55 2011 -0400

    refresh (create temporary patch)    d666137c5fe3ee4c4c812c706b1a3c539405ffd0


That's stgit leaving all those dangling references. I will experiment
with the current stgit and see if it is still leaving the dangling
references or if they are leftovers from an old bug.

-- 
Jon Smirl
jonsmirl@gmail.com
