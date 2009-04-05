From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: ensure quoted addresses are rfc2047 encoded
Date: Sat, 4 Apr 2009 23:23:05 -0400
Message-ID: <76718490904042023i3090dd79t8a8d11b21c0f7e13@mail.gmail.com>
References: <1238901726-47026-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 05:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqIyR-0001uk-Lu
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbZDEDXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756788AbZDEDXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:23:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:21124 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740AbZDEDXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:23:07 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1625868ywb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=QLBDaD9z3ZNOgneA7ilM/34y6Pa7ZOzjFUqeDvZnsOs=;
        b=o9yr+ZO3+WsJsGS4BoaoGTzYdCuW3fIHAxLKxJgF7QU3AJgURa+nknY4fSxqE7dQmN
         KCaG48yxerrMIwg+IyB5mwVq5b/E2Dj7ghDOmH0god1Bgpld32htdMP4N+6i2KLQQudU
         6lew2UWXme3iGlWaF+9tiWjtVEKcQ2Xdfy6tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=e/EN4yXsh5ah1+iCVjiVabEL2IltzaTHJk0XQ70MjxVyVJNLJhmcxMWt+zOy9cOskX
         ZR4NcFRA8i7C/wC3OkWkDtPaIU1w235zhrsE7ExxrZOzTySuA4UteDvmdqrg0SPrXzRt
         3yPgCTWzAo8DsOLN32UVD1p7RJvO4lAZ2s4Uk=
Received: by 10.151.78.12 with SMTP id f12mr2056810ybl.11.1238901785759; Sat, 
	04 Apr 2009 20:23:05 -0700 (PDT)
In-Reply-To: <1238901726-47026-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115624>

On Sat, Apr 4, 2009 at 11:22 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> sanitize_address assumes that quoted addresses (e.g., "first last"
> <first.last@example.com) do not need rfc2047 encoding, but this is
> not always the case.

OOOOOOOPPPS. Ignore.

j.
