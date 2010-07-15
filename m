From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] non-incremental mode for fast-export
Date: Wed, 14 Jul 2010 19:03:56 -0600
Message-ID: <AANLkTim9CU-2CNz8lUbKiKXHHICugMhts_1aIDP2_81g@mail.gmail.com>
References: <1278535562-14875-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 15 03:04:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZCrs-0006UG-O1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 03:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab0GOBD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 21:03:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58204 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942Ab0GOBD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 21:03:57 -0400
Received: by vws5 with SMTP id 5so458771vws.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=cNwDgFjAnRyFYXR0/QHXbkKg2ibFfjLBh2BReewIUdo=;
        b=KHb+AigoBm0/QDw6xpAW+yCik1B/7e1I9+5u5H4Ut3l2hGNqLIGnM+hrpdTvoXytNh
         SxpZQc7/j61bvcGJxzfeAHOzcozs+2Bur1308qlB9qqEX8sPJ2EFyehbux5yN0HWyKiM
         9OyDlynu+/cj8/aCa0G7hm/uefRVMoz7WiuvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Ywc0CoK/jUqwyIVsIvFT2Am/j1K9wKvM+tlTpYte8ijHxXw7Te+lJWnTXaNJ7W2M7+
         lv/SZo8Bd6DAPkaMFb/CWrRGi81ZPojeLoiKPv6pOUWUEo9YSPl21MyKB7ILGuKDKs2Y
         cR0sY/M7GJw+0GzhAGgZwmiSBqZ4aYOJEg6O8=
Received: by 10.220.90.212 with SMTP id j20mr3545503vcm.67.1279155836962; Wed, 
	14 Jul 2010 18:03:56 -0700 (PDT)
Received: by 10.220.99.211 with HTTP; Wed, 14 Jul 2010 18:03:56 -0700 (PDT)
In-Reply-To: <1278535562-14875-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151044>

On Wed, Jul 7, 2010 at 2:46 PM,  <newren@gmail.com> wrote:
> This patch series fixes silently dropped files in uses of fast-export
> involving both --import-marks and limiting files by path. =C2=A0It al=
so
> adds a new feature: a --full-tree option to switch from incremental t=
o
> comprehensive handling of files in commits. =C2=A0The two changes are
> related in that the bugfix consists of simply automatically activatin=
g
> the new feature in a case where it is required for correct operation.

Hmm..no comments.  Am I (and others at my $dayjob) unique enough in
our combination of options we use that no one else ever runs into this
mangling of exported repositories?

Elijah
