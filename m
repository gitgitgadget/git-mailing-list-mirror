From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 13:16:53 -0500
Message-ID: <5367d595c04ed_25278db2ec8b@nysa.notmuch>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
 <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
 <5365D91E.70207@alum.mit.edu>
 <536606AB.1020803@kdbg.org>
 <m2mwexke34.fsf@linux-m68k.org>
 <5366A09E.6030802@kdbg.org>
 <87ppjt6xjv.fsf@igel.home>
 <87lhugu7iw.fsf@fencepost.gnu.org>
 <87vbtk60lh.fsf@igel.home>
 <87d2fstuzw.fsf@fencepost.gnu.org>
 <87r4485vve.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi6f-0006KZ-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbaEES1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:27:37 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35927 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaEES1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:27:37 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so5645645obc.18
        for <git@vger.kernel.org>; Mon, 05 May 2014 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=i7FLH2IM7e2iioVUI8gD5WxS10tejAmOPMd68n7IXAU=;
        b=diW5C+bya2qhG8u4eSs8t1mtidLFm83Rute9Ao/cKMl+XDKdAMWtyOyvI/jaexMUaZ
         way850sfz6W7fsB3O9PHhOvJUIB3B31aV2MsAVx6BkanBPF8D63oWUXnZNGnORKru6Nv
         U/dfrKMAZwdj/u+3D4kq6nijXrDB5MlpouXaq6rubj8nj1GkWfHfRUTqEMtX0o69OYg0
         QBFHhflbBi5U3xiTXmwIc97dFa+PQ4zSEIBr3++1M1KGuyS9bPw8IcmjazE3KpCp3BJP
         Q2v7rQ7jzC/S1tvKqIUe2uQsyzIdVns+sKdWhtPKx/bhk+PIr5wxljyFYVsHmMPdUaUf
         h0aA==
X-Received: by 10.182.66.170 with SMTP id g10mr4857624obt.49.1399314456555;
        Mon, 05 May 2014 11:27:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pz8sm20981767obc.11.2014.05.05.11.27.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 11:27:35 -0700 (PDT)
In-Reply-To: <87r4485vve.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248155>

Andreas Schwab wrote:
> This thread is about objects of type struct object_id, and their
> address is always the same as the address of its first member.
> Nothing else is relevant.

Indeed. I suggest you ingore that guy, he will only derail the
discussion.

-- 
Felipe Contreras
