From: "Matthias Kestenholz" <mk@spinlock.ch>
Subject: Re: Failed expectations or bug?
Date: Thu, 4 Sep 2008 12:18:28 +0200
Message-ID: <1f6632e50809040318n2974cdf2t3664c759978dc8d3@mail.gmail.com>
References: <EA0C3F3E-0DA8-49A7-8151-5A2EC6C7BEEA@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pedro Melo" <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbBw9-0005tH-1n
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYIDKSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYIDKSa
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:18:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:37129 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIDKS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:18:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3224490rvb.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 03:18:29 -0700 (PDT)
Received: by 10.141.163.12 with SMTP id q12mr5554111rvo.190.1220523508961;
        Thu, 04 Sep 2008 03:18:28 -0700 (PDT)
Received: by 10.141.115.1 with HTTP; Thu, 4 Sep 2008 03:18:28 -0700 (PDT)
In-Reply-To: <EA0C3F3E-0DA8-49A7-8151-5A2EC6C7BEEA@simplicidade.org>
Content-Disposition: inline
X-Google-Sender-Auth: 302a32289eb32bed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94919>

On Thu, Sep 4, 2008 at 11:49 AM, Pedro Melo <melo@simplicidade.org> wrote:
> Hi,
>
> I was learning about git rename detection and came across a unexpected
> result. See the following sequence:
>
> [...]
>
> Maybe I have the wrong expectations, but after the merge I was expecting
> either:
>
>  * b and c have the same content, with the modified D;
>  * b has the modifications made in master, and c has the original content.
>
> I did not expect the patch to 'a' in master to propagate across the copy to
> c.
>
> What am I doing wrong here?
>

The rename detection needs more than a single character to work reliably.

If you do roughly the same test but with bigger files you should get better the
results.

Matthias
