From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git Log and History Simplification
Date: Mon, 17 Dec 2012 18:49:55 +0700
Message-ID: <CACsJy8BsL03zr_wGZH5kqS0NaMfPKct2T7_62jstxRB4c_FudQ@mail.gmail.com>
References: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dinesh Subramani <dinesh.subramani@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZDY-0007jv-75
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab2LQLu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 06:50:27 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36068 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2LQLu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:50:26 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5794634oag.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c9xXh7+APJEWsxe5rWLVSvlYJdAM2jHfI9n4wxPKZgg=;
        b=EDSgQfEC93l62/2mhndfCL0mCOU7qPOIg1AN5Y5ldtiHohZmyedyxjkv1ePBGJ3Yg7
         zV9L9vlzAL1iyQ/l7/NdNV1AqgIdOHoP8cnwPCRtR8mpUD+xt6IgQU60/y32fMiXC1bG
         LUi85JcYzMenZS103oJA3sd1UCAMA2DtP0O5qkVwVkwPFZySR2fz2UkrRG+We+b5e5Ny
         +I1bbfBWsfQ8faAGIUHdojNdabfvQ2XtuGcW5IMawr3qrCXIlGCyU3pMaCVxXa4J6Kvj
         FzNCBxQ9MPTz1R4AlQkoD7dgJV/FstGdhigmKgZHm/ew2MphsirY6y1A1S0upHehNYIx
         oF9A==
Received: by 10.182.177.72 with SMTP id co8mr11382288obc.53.1355745025700;
 Mon, 17 Dec 2012 03:50:25 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 17 Dec 2012 03:49:55 -0800 (PST)
In-Reply-To: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211679>

On Mon, Dec 17, 2012 at 6:33 PM, Dinesh Subramani
<dinesh.subramani@gmail.com> wrote:
> I am using the below command :
>
> git log --stat --decorate=full --since=<date>
>
> Can you please let me know if the above command will list all the
> commits and would not skip any of the commits due to History
> Simplification. Any help would be very useful.

If my memory is still functioning, history simplification only takes
place when you specify pathspec. The above command does not have
pathspec, so no history simplification.
-- 
Duy
