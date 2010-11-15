From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 07/10] checkout: add -S to update sparse checkout
Date: Tue, 16 Nov 2010 06:52:50 +0900
Message-ID: <87bp5qmez1.fsf@catnip.gol.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
	<1289817410-32470-8-git-send-email-pclouds@gmail.com>
	<20101115211636.GH16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 22:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI6z1-0007up-2l
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 22:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab0KOVw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 16:52:57 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:49991 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab0KOVw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 16:52:57 -0500
Received: from 123.230.98.87.eo.eaccess.ne.jp ([123.230.98.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1PI6yq-0008LV-13; Tue, 16 Nov 2010 06:52:52 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 3E5B9DF91; Tue, 16 Nov 2010 06:52:51 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20101115211636.GH16385@burratino> (Jonathan Nieder's message of
	"Mon, 15 Nov 2010 15:16:36 -0600")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161517>

Jonathan Nieder <jrnieder@gmail.com> writes:
>> +-S::
>> +--update-sparse-checkout::
>> +	An editor is invoked to let you update your sparse checkout
>> +	patterns. The updated patterns will be saved in
>> +	$GIT_DIR/info/sparse-checkout. The working directory is also
>> +	updated. An empty file will abort the process.
>
> Wording nit: this doesn't make the worktree more up-to-date.  How
> about:
>
>  --edit-sparse-checkout
>  --define-work-area
>  --narrow-worktree
>
> Hmph.
>
> --edit-sparse-checkout seems best for consistency of the choices I can
> think of.

"--change-sparse-checkout"?

Onna-account of "edit" sounding like you're actually somehow editting
the checkout itself...  OTOH, since it invokes the editor... hmmm

BTW, wouldn't it be more convenient to allow specifying patterns
directly via the command line?  I'd think in many (maybe the majority
of) cases people will really only want one entry, and having to edit a
file to specify it seems vaguely annoying...

-Miles

-- 
.Numeric stability is probably not all that important when you're guessing.
