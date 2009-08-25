From: Matthias Kestenholz <mk@feinheit.ch>
Subject: Re: git only one file
Date: Tue, 25 Aug 2009 21:38:20 +0200
Message-ID: <1f6632e50908251238o2fef1048uc9aa27b38f5d7689@mail.gmail.com>
References: <25140456.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: synhedionn <synhedionn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg1qn-00060g-L3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 21:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbZHYTi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbZHYTi2
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 15:38:28 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34556 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098AbZHYTi1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 15:38:27 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so777106ewy.17
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 12:38:28 -0700 (PDT)
Received: by 10.210.102.19 with SMTP id z19mr1084271ebb.6.1251229100938; Tue, 
	25 Aug 2009 12:38:20 -0700 (PDT)
In-Reply-To: <25140456.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127047>

On Tue, Aug 25, 2009 at 9:12 PM, synhedionn<synhedionn@gmail.com> wrote=
:
>
> with git add . =C2=A0, a directory is expected, but I don't need all =
my files to
> be recorded, only one of my thousands, so how can I record just 1 fil=
e?

By only adding this file to the index. Use "git add $yourfile" instead
of "git add ."

If you do not want to see your thousands of files in the directory
when running git status, you can simply create a .gitignore file with
* as content. Git will still notify you about files which it already
knows about, even though the .gitignore entry tells it to ignore
everything.



Matthias
