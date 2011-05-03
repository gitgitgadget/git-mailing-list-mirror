From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 1/4] t5541-http-push: add test for chunked
Date: Tue, 3 May 2011 09:32:41 -0700
Message-ID: <BANLkTimmQAUKXfe3SntpDpKjc8XhEpjeJA@mail.gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com> <1304437649-7052-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dan McGee <dpmcgee@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:33:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHIX7-0006XG-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 18:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab1ECQdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 12:33:03 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46314 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1ECQdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 12:33:02 -0400
Received: by vxi39 with SMTP id 39so201618vxi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 09:33:01 -0700 (PDT)
Received: by 10.52.92.45 with SMTP id cj13mr63621vdb.105.1304440381091; Tue,
 03 May 2011 09:33:01 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Tue, 3 May 2011 09:32:41 -0700 (PDT)
In-Reply-To: <1304437649-7052-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172670>

On Tue, May 3, 2011 at 08:47, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Trigger the chunked type of pushing for smart HTTP. This can serve as=
 a
> regression test for the issue fixed in 1e41827 (http: clear POSTFIELD=
S
> when initializing a slot).
=2E..
> + =A0 =A0 =A0 # to trigger chunked pushing, we need a sufficiently la=
rge pack - use
> + =A0 =A0 =A0 # git v0.99

The better way to trigger this is to set http.postBuffer to something
very small, e.g. "4".

--=20
Shawn.
