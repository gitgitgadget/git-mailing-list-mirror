From: robert mena <robert.mena@gmail.com>
Subject: Unable to remove a file
Date: Mon, 3 Oct 2011 10:21:58 -0400
Message-ID: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 16:22:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAjPC-0006Fh-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 16:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab1JCOWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 10:22:01 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35414 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab1JCOWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 10:22:00 -0400
Received: by eya28 with SMTP id 28so2829531eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Baq3r7DvzDf2PE8hKPLhlZ8s2myEHgipBpFh4cmZILY=;
        b=HsFUDf0C9a4wrWJxG4C+Is+aHd42OpwqxBdfMgkLDynnioaYdQ46C54MLjvb4GHyMg
         ROeC1QkNNpxzZoNEQXBWWuc2PxThWOSXiZTw1+KaClMswGjNUrHW+QwDivoxis8ZgFFY
         bCU4Y+sRu99fGxOVak/Jep0XbGqAlOGKXJDbk=
Received: by 10.223.37.91 with SMTP id w27mr275985fad.111.1317651719019; Mon,
 03 Oct 2011 07:21:59 -0700 (PDT)
Received: by 10.223.104.66 with HTTP; Mon, 3 Oct 2011 07:21:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182663>

Hi,

I had a file called \ under a directory scripts.  I've removed,
committed, pushed to the server BUT my windows clients when they try
to clone I stop because of this.

Don't ask me why and it is probably windows/the IDE fault but I have
to solve it.

I found the command filter but it is not working.

git filter-branch --index-filter 'git rm --cached scripts/\\' HEAD
Rewrite b75a1a3af45a4d82fcfe7a6148fc4d6e1c55ee91 (1/48)rm 'scripts/\'
Rewrite 8a32d6194e9c46dc0f1ce60a2245fcbcd7c12d00 (2/48)rm 'scripts/\'
Rewrite 892bba8bd7563186d7b1c493cf05d8823cfe2f7b (3/48)rm 'scripts/\'
Rewrite 0be74d8143f670b08806510dd09cf77029f57bcb (4/48)rm 'scripts/\'
Rewrite ec7e45a5d8100b7a1e49ca8d0cf5ec5d638f2dd7 (5/48)rm 'scripts/\'
Rewrite c9dde5bf86391a66f80dc86bcc3078c78866b5da (6/48)rm 'scripts/\'
Rewrite 499be785b2538a1d6b382e1a0d6e9bdc8a771a76 (7/48)rm 'scripts/\'
Rewrite 327ac340d4dee02bc2bfed07bd94df5f87b8036c (8/48)rm 'scripts/\'
Rewrite 5ae256edce2959585b2819c4d6d0d4704b02984a (9/48)rm 'scripts/\'
Rewrite 3811ef08c5a2be9f4f049c50caf501944483ec72 (10/48)rm 'scripts/\'
Rewrite 52b3de12d3cde4f6bb920d335fe8629d368d965b (11/48)rm 'scripts/\'
Rewrite ff115cd8f3213d8218d369361d5ee77010081c22 (12/48)rm 'scripts/\'
Rewrite d28c02b462e8ee70c6d516d7d2c6754b82bfc80e (13/48)rm 'scripts/\'
Rewrite 173aecfa81f64644747934f815befb8f83daf6ce (14/48)rm 'scripts/\'
Rewrite d4649a98584c25c1c8d52adbd49d822c961dc7cb (15/48)rm 'scripts/\'
Rewrite d026354566abc0d135cdd3838fa96055baa29a03 (16/48)rm 'scripts/\'
Rewrite 9f7869cf30bc0c04e072859bfbc1325758a5e893 (17/48)rm 'scripts/\'
Rewrite 6058b6d0b783cd290ce78e344f442d161989b72d (18/48)rm 'scripts/\'
Rewrite 7f7842d461a645223e39d5b6c451ec8b3e8f89a4 (19/48)rm 'scripts/\'
Rewrite 11f9ad3c22746e4fddb407790eb0db4db709902d (20/48)fatal:
pathspec 'scripts/\' did not match any files
index filter failed: git rm --cached scripts/\

How can I really delete this without having to start from scratch?  I
won't hold my breath for windows or even the IDE's to detect this and
solve it.
