From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Update *.po with git.pot?
Date: Fri, 18 Mar 2016 21:19:57 +0100
Message-ID: <CAN0XMO+8PQNXPRgROd9oVqHzTsgLo_k1yP-MLpqK5N44+1ShDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>, DJm00n@mail.ru,
	Marco Sousa <marcomsousa@gmail.com>, cwryu@debian.org,
	Marco Paolone <marcopaolone@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	git <git@vger.kernel.org>
To: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah0sU-0000fH-92
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 21:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbcCRUUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 16:20:04 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36765 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbcCRUUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 16:20:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id l124so43688538wmf.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=6p6DGMzv2+e0kQP0Y8RToCRU1epyqJorbiRWxby+Qfs=;
        b=swmLsuULwhZYpB731Ofv5P4hvFel0xNoTL9PqmuLHoyVwD7PTu4iAsJNF39NCahK1o
         CmmEUVf8P/ZX4OgyrcQVtgOQn1DYAymxLNCPGTQ3X7u9lC5TLjZhI2nh42pcCCwuAUM2
         jqgGVHzwZuHx5GCX0PtBCLuAe6m7d3At8L+lRI/GALprf9Y6cJQXfEywXtUzpzvqJvPP
         7SgT+k7z55u+hENaHXIoyQ1L8MxceT9+uuWd6Mul+rgZsxm5ggMx+L53r799yk7/b2Jr
         cSSjstm0Vhfn+tu2FqqOGZVSYz1o+VoiKnMlu0rLc8kqL6bhZqJYfsfIaxqiiCZ0Xji3
         2tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=6p6DGMzv2+e0kQP0Y8RToCRU1epyqJorbiRWxby+Qfs=;
        b=jrqTmzxNzbIffeZP42W8F6yEvsn4xzxTUNQbcRDynllYSm6cYjscPY4nFIkQHaCVqs
         0AqPIy9AXIHvuIjghdzaGPbfT0z4Jpmk7hNZ5qEFi+hEUaLQz+hYfxwQQ6dfc6E+u09p
         +Zb8SN72bwEqKO47iNpVn1LMV4cvCfKALTjwrapYytiBUsLifjAQ6/Oy25eNgMImxsKR
         zQzG3k7H5T+Ce0Z93X4CdlRvU2ILJtXTOHvyiUNIU6EhrLXre7bfdcwDrc6xqMed9D0R
         DEwsVmoh/NDCPFFP7OuWI+wjlUjx1SWIRMRbPLg5jSkVNFW3ow1GSoMfkWkJyyxGSQ2x
         X0vQ==
X-Gm-Message-State: AD7BkJJID9HGV/uPhUfwXXjUgEhfQr17zILcOp4LUClzD6nWPXxtOv9KAbv3JljXULJUXIw1qjOKChRGF8M0IA==
X-Received: by 10.194.171.66 with SMTP id as2mr17842208wjc.110.1458332397626;
 Fri, 18 Mar 2016 13:19:57 -0700 (PDT)
Received: by 10.28.23.10 with HTTP; Fri, 18 Mar 2016 13:19:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289247>

When a translation round starts for a Git release, the
git.pot file will be updated and translators msgmerge
their .po-files accordingly before translating. This results
in a huge change to the .po-file as line numbers and
stuff gets updated.

Since translations are made in one commit, this commit
is messed up with the msgmerge update so when you
look at the commit later, you'll have a hard time to find
out what the actual changes in translations were.

We could improve this by making git.pot-updates update
the *.po files as well, so further updates from translators
will only contain actual translations. I think this is what the
gitk project does. It will make the history of *.po-files much
more readable.

Ralf
