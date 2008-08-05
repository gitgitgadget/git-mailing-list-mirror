From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] Finding the commit that removed a symbol?
Date: Tue, 5 Aug 2008 14:00:55 +0200
Message-ID: <200808051400.55936.brian.foster@innova-card.com>
References: <200808051343.07370.brian.foster@innova-card.com> <57518fd10808050447h2df6da07vb001ed8862076992@mail.gmail.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 14:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQLEy-00055L-9X
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 14:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324AbYHEMBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 08:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758764AbYHEMBI
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 08:01:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:35302 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757861AbYHEMBH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 08:01:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1837430wri.5
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=HKCC1plVfUbQGG4PO7WD9bcKbc05CZiwBZyJPHciJHc=;
        b=hbtYDh70Ur9RQiScYb6ZjIK0yU5T6sOqF4DG5zH0XazLXuQ+vho4aFCn8V6dB+rxl5
         NfDVYF5P++KYFfoz4Xg8AHFJZdMYPvX3iUVwhdfLs7xdBhEMUkVkijIhZthhsNO1lNv0
         mwZUfnqT1UnqCQI2TeqBcLj0pfOR4uVZPrT8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=m9SYDM/ptGi+0YrViXQpH865bMAtTIpJDKyZt8C+9+eYWAidEf/5Jnd3R/VDhIe6pq
         it0EVK6ed7qToyCUoEOG5c1/JaTTDJIsBGRw+LqSDpJTU7oH0P+Kfw9Q059vYXbmBhqX
         HZBWZN4/b5D3zjnzsSBkzugvzf7lsJ4YWoptw=
Received: by 10.90.49.8 with SMTP id w8mr1302460agw.66.1217937666254;
        Tue, 05 Aug 2008 05:01:06 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id m6sm8932057wrm.35.2008.08.05.05.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 05:01:05 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <57518fd10808050447h2df6da07vb001ed8862076992@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91438>

On Tuesday 05 August 2008 13:47:35 Jonathan del Strother wrote:
>[ ... ]
> You probably want git log -S'MySymbol'

Jonathan,

  Thanks!  That did it, exactly (finding, in fact, only
 two commits:  The one that added the symbol, and the one
 I was looking for, the one that removed it).

  I was unwares of =E2=80=98-S=E2=80=99 because git-log(1) for v1.5.2.5
 did not list it (albeit it seems to exist).  Consulting
 the v1.5.5 documentation, it's listed.  Thanks to whoever
 fixed/updated the documentation.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
