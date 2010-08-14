From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] completion: make compatible with zsh
Date: Fri, 13 Aug 2010 23:17:32 -0400
Message-ID: <AANLkTikrE1Fy2Trz6b4MSJk6KzMvH9gDoYWwOEgYkFRJ@mail.gmail.com>
References: <1280890654-18486-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 05:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok7G8-0007dc-2m
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 05:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498Ab0HNDRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 23:17:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35358 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475Ab0HNDRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 23:17:53 -0400
Received: by qwh6 with SMTP id 6so3450328qwh.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Z3CxzJlqRKTCFIg03YuxlRzxNctPbrxcicuwV5k1HbM=;
        b=V/WfoXcN7mXJPzl29d2bTBz+GDa2CI58ZYeih+4UMXzGgJ9Gi46WbLzU1Fs/2x99Hj
         Iv68sI7ZjRNeKl99uPP2tt/n6Bi8SAXwmI1xq5GPMJI2rIMB/h0ZQh0U8f9sTASOWMWf
         adxOiEaLHbKIdmty+C/gAeGTIQ31YUjKlS8xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=BGNuOKEkkuUa2QSeGvlpyLlsTAPMR1fLSPUGWDxPthcdhrKMwrAlPyuGIzpwH8l9fA
         OnNBIgZ62RTDMlwRICJfBlwMUNYEj+/A2BDFFuqgl3jVWScZc3PhfXokOm5o/yfv0D7e
         9WDLxzCDqzfiZwEhB5H5XjRNia7GYPBhx0DsQ=
Received: by 10.224.2.85 with SMTP id 21mr1630531qai.74.1281755872401; Fri, 13
 Aug 2010 20:17:52 -0700 (PDT)
Received: by 10.229.72.139 with HTTP; Fri, 13 Aug 2010 20:17:32 -0700 (PDT)
In-Reply-To: <1280890654-18486-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153543>

On Tue, Aug 3, 2010 at 10:57 PM, Mark Lodato <lodatom@gmail.com> wrote:
> Modify git-completion.bash to work with both bash and zsh. =C2=A0Most=
 code
> works fine, but a few things need tweaking. =C2=A0Where possible, cod=
e is
> written in such a way that both shells interpret fine, but some areas
> need special-casing.

Is there any interest in this patch, or anything I could do that would
make it more likely to be accepted?  Perhaps at least some of these
changes could be implemented.

Thanks,
Mark
