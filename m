From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 03/19] ref-filter: implement '--points-at' option
Date: Tue, 23 Jun 2015 16:19:22 +0530
Message-ID: <CAOLa=ZTsD1MssMG0yz5GN1wU+hsDr4z4iXWBYmFOUTnzW1h+Og@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-3-git-send-email-karthik.188@gmail.com>
 <CAPig+cRGWG=L0JmSEtnxAyV=NTsq281Ot7E85HB4buDnMPHc1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 12:50:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7LmA-0007dv-KI
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbbFWKtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:49:53 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36114 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbbFWKtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:49:52 -0400
Received: by oigb199 with SMTP id b199so3949438oig.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+MGvxO3CANjSsHF60hYMN7EnmoUi2Una9QIPKdz5S0E=;
        b=mAFYmwglmehmSRWLFDRSYDK2zzaHstu3WLCFlu5EwXnwIUkvpQvr5j6qASKalCeokz
         Jt88JAF2jSUVFQTIiM41KcRWEE2vF6i5IQx/ZQ8i8gS6WfYanVO9oTJ31FLs1TXJCRNn
         u6cDlu1s7mabubrcN2IdXFc0FlV5qd29mHiSLvmr0gYNDE3YSm/V7+q2wntg0zkIEVwA
         PQxdOy3bQg6U3YGmt5maT3PbX0WzPfrU5q/HFFJc0iQ+l6uRLF8hyO4njs04ZW/D5/ks
         q1ZLKcfOWUGBMDa3oTIQR3y6z7CW1PgZi9n01K99+/1XEA+5fy02tn0rysNm156vzhr5
         JocA==
X-Received: by 10.60.58.136 with SMTP id r8mr29472249oeq.30.1435056592284;
 Tue, 23 Jun 2015 03:49:52 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 23 Jun 2015 03:49:22 -0700 (PDT)
In-Reply-To: <CAPig+cRGWG=L0JmSEtnxAyV=NTsq281Ot7E85HB4buDnMPHc1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272446>

On Tue, Jun 23, 2015 at 4:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> s/a one/one/
>

Noted! Thanks

-- 
Regards,
Karthik Nayak
