From: Duy Nguyen <pclouds@gmail.com>
Subject: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Fri, 7 Mar 2014 08:38:26 +0700
Message-ID: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLjkb-000368-JG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 02:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaCGBi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 20:38:58 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61982 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaCGBi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 20:38:57 -0500
Received: by mail-qc0-f172.google.com with SMTP id i8so4021676qcq.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 17:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=sX3uNE/6vdIuK9jzYD9AknsbqdyS1jYcz8o9MiE+HpI=;
        b=xxxZqaV30GFyZMB2sR6hgvPla++IubkJi6yLDZiYbl/GMo9XTHHMw/M113oxsY11w5
         Y7gr93Z5elQ9dsD/vmdS/kPUczxVADPKW3HsA1NNdapXCpEe6kGEr7E73t7drAI+RuFa
         qIEBrB6LVlV5ILvWl5c2LW7aL0lULVG8IE6Ui+T41+o50m+oqzj47KmjueOkGMXRyknL
         k93yMmn1kY20/FbpSn6ODNRXj4ojNqqCFFGD5aqFAGkGP3ZjbFibVm/rrzwOyubghijA
         OHsJKRu31X3IIqBB381JrWpaod7NMAKxxIkN/mb+e3JFTEj8uFwGfXsxuD0fiITN0HZv
         2nlQ==
X-Received: by 10.224.136.195 with SMTP id s3mr6848416qat.95.1394156336755;
 Thu, 06 Mar 2014 17:38:56 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 17:38:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243583>

Currently in order to avoid --[no]-xxx form we have to resort to
declare full struct option. It'd be nice to have a set of OPT_* macros
with PARSE_OPT_NONEG set. Find and update all "struct option []"
declarations with the new macros (including ones that should never
accept --no- form, but do anyway).
-- 
Duy
