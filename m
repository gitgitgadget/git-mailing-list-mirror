From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 13:49:44 +0300
Message-ID: <2E60EB9E-E06B-4A5C-AC97-38847F300CAC@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 12:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We0AS-0001Nx-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 12:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbaDZKtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 06:49:06 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:46301 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaDZKtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 06:49:04 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3462616eei.0
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eao5kqvD3D0jTuH04WP4VF9qDJiglZp/Xw2lwGIA/ts=;
        b=bK6otHKOXo/yqwwCQFejz5kpVUYyNzRO0gqL/BEXvP7sQXzckxEy1FTWHtPezUV4Vr
         FvAqlazJthaPI10YVJCnACtxZ+e4DiPW9bwpb0AFUNUqqPU4JKLn59BFk836pQJzhkKG
         iTAH0oYBmy97Zm83ErV4Pfyh6asaJ38BdquCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=eao5kqvD3D0jTuH04WP4VF9qDJiglZp/Xw2lwGIA/ts=;
        b=L2JfLcmTYzEnpmNipztO6ZrKCL128gpAqIBD5GiTJCRLWQv3ob9RhIv0urhR/beY16
         PRzHuM0UQIloGSfUxg9Brsf1n7AbJ3MwxKoJHnBcPVCyzFkZtQ5qvaBPLVGr+9+IHTKh
         ba+7RBJ+J4cmBb0wo2WrCCA+1CVhE9dBOYPQkjKJfMV9L9LoPnmk3Vc81EefdzOlEsQw
         ZWPePyZGF2+Wy9Fklyp1RzhbmKZyzPir1sWPF7TBgP1QPsuxiqbaF9/frheCqlXaD/ZM
         i1+KeeR2O32mj/78eWYv9qqyA3hiOWRzhiCXxZn8uJX2jdnIl317+rSZa0KVkRrV8lwS
         O1qQ==
X-Gm-Message-State: ALoCoQn08GF7wEgzeJu8u09R0cC6P7SNbLHvohbRXs6RGeaQxtALXD0c+jbL3AxKbpVYLQ/UJf/g
X-Received: by 10.15.53.69 with SMTP id q45mr17370984eew.22.1398509342306;
        Sat, 26 Apr 2014 03:49:02 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id x45sm32373289eeu.23.2014.04.26.03.49.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 03:49:01 -0700 (PDT)
In-Reply-To: <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247154>

On a side note, I noticed some of the keywords I added shouldn=92t be t=
here.

I just realised that simple statements have no reason to be there, but =
only
block definitions. I=92ll reduce the size of this patch on the keywords=
 part.

Thanks,
Marius