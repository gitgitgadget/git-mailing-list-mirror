From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 6/6] Refresh and expand the tutorial (not finished)
Date: Mon, 6 Oct 2008 22:25:45 +0100
Message-ID: <b0943d9e0810061425u3ead1de5re1a252f03c2d09b3@mail.gmail.com>
References: <20081005155450.19886.43748.stgit@yoghurt>
	 <20081005160203.19886.33463.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 23:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmxbV-0001eJ-4J
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 23:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYJFVZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYJFVZq
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 17:25:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:41973 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbYJFVZp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 17:25:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3156223rvb.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QUFehjW9fOq89Uo8Qd9NCSd31s8mi90jApZD8yzDSak=;
        b=B0y7jujIVIt/Oa5E+yEEL4PU0EH148+dvqmqnGSwgxpJDE0DkTLX7k9HqQpn8dEUC+
         Gig7CP4YIX1fMlGgEYxwaRL+eNnoGzrO6nOyJrM8MxeqiQIJHxF31RWY9uGIEQVLEXYL
         0/8FpPz0Xy1p2fnEP6VfYnh5xyIAcIcNTSa8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=utLDzovg+x5zudxUHKAVRhw0CIwveRJhj8BkcRm3L3f12dPabn3halaNAhMtTjOpjS
         D/7Hh/lheYJ9EbhrauJA5Rqv8zlmdOvaeg8r347TrwZx3ozmUM+6QjerN6DE32vECyeW
         M1jOI3bi3doqKOQb9Uel4J1aDdLR50LZNlXGc=
Received: by 10.140.250.14 with SMTP id x14mr626393rvh.1.1223328345106;
        Mon, 06 Oct 2008 14:25:45 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Mon, 6 Oct 2008 14:25:45 -0700 (PDT)
In-Reply-To: <20081005160203.19886.33463.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97633>

2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
> This is a first pass at expanding the tutorial, fixing its formatting=
,
> and updating it with the new things that have happened in StGit.
>
> There are a number of things still left to do in the second half of
> the document; they are tagged with "TODO".

Thanks for this. Even with the TODOs, I think we can merge them into
the master branch so that I have the same copy as you. Do you plan to
do more work on the tutorial (so that we don't duplicate)?

> -Layout of the .git directory

Should we mention the metadata storage somewhere? This is probably too
advanced for the tutorial but might be useful to have it in a
development document (for other to understand where we keep things).
Actually, is the automatically generated documentation from the new
infrastructure enough?

--=20
Catalin
