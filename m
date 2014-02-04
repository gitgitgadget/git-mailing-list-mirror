From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t7101, t7014: rename test files to indicate what
 that file is for
Date: Tue, 4 Feb 2014 08:05:23 -0800
Message-ID: <20140204160523.GK30398@google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 17:05:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAiVP-0007z3-9z
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 17:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbaBDQFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 11:05:33 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58182 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbaBDQFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 11:05:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id um1so8678369pbc.33
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GjSVZZT6RqqJkfoxinN4RFT4zT8WpBnifXj3Mp1YAgg=;
        b=0x6Rs9YlBEesWW7e3uXQKWr0wnmln1xzqfgdAIsEAcCc62KnBIGkdLSahpVx7OmAR8
         VXghtzy2sU85R7Wic4pGkCSlJTDkww/ZqZj+/KclfOYplxmneFKUDVAATLZuswHGt7F+
         JrpKMb70RfPnRYgHW73Dhw3G+FYlxJiTx/DxyK5CoY6Au0i/IBUHy3YU29jk3HlWAjEy
         il8rTT7DfkJWqqxknUwRoleVE3GEclB7vqIz8eLR5SohjAhF+ohaONARDkcweOJSAVrx
         X1UjwBZID8NNp90WOqZp0nPQJzeh/I+L/Qj/k6cX1kmF1zZ2oGji05lAtkOzfXoruxyr
         I2tQ==
X-Received: by 10.68.35.129 with SMTP id h1mr10539434pbj.163.1391529926413;
        Tue, 04 Feb 2014 08:05:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iq10sm67512613pbc.14.2014.02.04.08.05.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Feb 2014 08:05:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391480409-25727-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241530>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Makes sense.

[...]
>  t/t7101-reset-empty-subdirs.sh (new +x) | 63 +++++++++++++++++++++++=
++++++++++
>  t/t7101-reset.sh (gone)                 | 63 -----------------------=
----------
>  t/t7104-reset-hard.sh (new +x)          | 46 +++++++++++++++++++++++=
+
>  t/t7104-reset.sh (gone)                 | 46 -----------------------=
-

Hm, summary incorporated in the diffstat.  Neat. :)

format-patch -M tells me that this indeed just renamed the files, so
fwiw

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
