From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] enable "no-done" extension only when serving over smart-http
Date: Tue, 29 Mar 2011 10:31:11 -0700
Message-ID: <AANLkTinuWGN9FcQoONboFK9WdrRYU+NypmWjNAfGc=_B@mail.gmail.com>
References: <7vlizxsv82.fsf@alter.siamese.dyndns.org> <7vhbalsutw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4clU-0004ND-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab1C2Rbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:31:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37393 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1C2Rbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:31:32 -0400
Received: by vws1 with SMTP id 1so340261vws.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:31:31 -0700 (PDT)
Received: by 10.52.88.12 with SMTP id bc12mr38917vdb.243.1301419891171; Tue,
 29 Mar 2011 10:31:31 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 29 Mar 2011 10:31:11 -0700 (PDT)
In-Reply-To: <7vhbalsutw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170287>

On Tue, Mar 29, 2011 at 10:24, Junio C Hamano <gitster@pobox.com> wrote:
> Do not advertise no-done capability when upload-pack is not serving over
> smart-http, as there is no way for this server to know when it should stop
> reading in-flight data from the client, even though it is necessary to
> drain all the in-flight data in order to unblock the client.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
