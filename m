From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 16:30:11 -0600
Message-ID: <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 00:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME9pt-0000T2-DZ
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 00:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZFIWaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbZFIWaK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 18:30:10 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:51020 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZFIWaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 18:30:09 -0400
Received: by qyk10 with SMTP id 10so2882qyk.33
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I/aUXDT0jIO3cb7VhO/U/GoJVA/F/3O/jOpDNxxPDFI=;
        b=T2XYVjYCW2nq/eIvFyxbHTTEc05fippK0rudZtkM4pDiPZq2TjI0YdDkA8+GdkiMZh
         +nerQ7GegGOTA1iRIfIcTorectKqvS3v20sorkkn9BtWADiXRPhe50pFPDuVoKCKB2HN
         ykVUXlb7nPf9qy9NJAOIVaMn6EgjoV6jAryyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ivtTlYjHAX/oYauz05qXzZvUKSd/nxHAb7CmJj2icLL+8bbxz2MdyK06klntk0to69
         7F9K0s5gpZOlqwaPoWTx/CkM6XqU7Dqt4cBy7Cij7VJ0HGVxkbptPwHrp+mvf5V8GGlR
         dvZCjBU5eo2lYpDlSoJpbkwazYSQtk45DdyJU=
Received: by 10.229.99.135 with SMTP id u7mr148821qcn.44.1244586611051; Tue, 
	09 Jun 2009 15:30:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121232>

On Tue, Jun 9, 2009 at 4:14 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> On Tue, 9 Jun 2009, Scott Chacon wrote:
>>
>> * breaks the various things that 'checkout' does into separate
>> commands - moves 'revert' to doing what 'checkout -- path' does
>
> No.
<snip>
> Feel free to add other "helper" aliases that are actually _new_ and have
> no pre-existing git meaning, but not things like this. Not breaking
> existing git usage just because somebody is too stupid and/or lazy to try
> to learn a new word.

Do you object to using 'revert' in the name of the new command or just
to having the new command take over the exact name 'revert'?  I'd like
to propose making the reverting of edits functionality available under
the command name 'revert-edits', while leaving the existing reverting
of commits functionality under 'revert', but I'm not sure if that
would run afoul of your objections as well.


Elijah
