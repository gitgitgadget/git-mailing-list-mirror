From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: wrong check condition in patch-delta.c?
Date: Tue, 20 Jun 2006 13:32:21 +0700
Message-ID: <fcaeb9bf0606192332j5b2ee4b9ycf2c63c7b1820204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 20 08:32:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZmm-0007zt-CJ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 08:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFTGcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWFTGcW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 02:32:22 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:34442 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964987AbWFTGcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 02:32:22 -0400
Received: by wx-out-0102.google.com with SMTP id h28so897894wxd
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 23:32:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HHk/gekauwnV10UPpp4f0IlQvnD8N9p6V1P6G7J5Wd8fzuwAvayI9DXXe4OknIfY7LOWAUsH971+W1bUVOmA/yho8z7gQtM8xZf5LJXLX6YfSwZ+euXjbhsasFAsBiZoByzHlBzThbseBkChWA0xYbvwNTJRMRNgKDDJ8EQbZ6Q=
Received: by 10.70.92.17 with SMTP id p17mr9868535wxb;
        Mon, 19 Jun 2006 23:32:21 -0700 (PDT)
Received: by 10.70.45.11 with HTTP; Mon, 19 Jun 2006 23:32:21 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22174>

Hi,
While inspecting patch-delta.c, I encounter this:
                       if (cp_off + cp_size < cp_size ||
                           cp_off + cp_size > src_size ||
                           cp_size > size)
                               goto bad;
"cp_off + cp_size < cp_size" doesn't make sense to me. Is it on purpose?
