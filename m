From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: How to split a big commit
Date: Mon, 4 Apr 2011 18:52:45 +0700
Message-ID: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 13:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6iLR-0005oE-OT
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 13:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab1DDLxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 07:53:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58780 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab1DDLxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 07:53:15 -0400
Received: by pzk9 with SMTP id 9so1318772pzk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=r2xolZkZNIKTdFtNkE1y+yv0ZSm5sHSoZVDYJfSmZCY=;
        b=nXZm/SgQGxAnUWdRSpwXYE8n0nbTOubfN+tLdlGMGQ2u5GutAtZPyOByJxWTNqKode
         tMTy7BOi85lEIV41EYfJ8lvqetyErdRP+RmqCqjncIqjufHuxNC58sP/ufDs3wv02Ajj
         Xr/SgJmoUr4ln+qjzjX1+IJ+7+Q19Vdabf9iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=iZ9thMha9LuhabS+v8neOmvHeKF89IO/cwtMfXRIiSVOwztBoo54cqpedOvDkv9H9a
         YLyYNzvs3h6jAY/iyKnOByibweWJs+5NvjMOv3DJy8llpffmV0DiRZalm+HQbo5LyC4/
         lga4iG0yjWgdhhMGoHTW2VTYRw7EZuukLeD2Q=
Received: by 10.142.142.4 with SMTP id p4mr217369wfd.43.1301917995033; Mon, 04
 Apr 2011 04:53:15 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Mon, 4 Apr 2011 04:52:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170805>

After a lot of small commits and a few mixed up large commits, it was
too messy that I merged them all into one big commit then started
spliting it into smaller, reasonable patches. Just wonder if anybody
else faces the same thing and how they deal with it. I used "git reset
--soft <big commit>^" and "git add -N" because there were new files,
but it was clumsy.
-- 
Duy
