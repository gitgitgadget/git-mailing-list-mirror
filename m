From: skillzero@gmail.com
Subject: git list binary and/or non-binary files?
Date: Mon, 24 Aug 2009 14:50:43 -0700
Message-ID: <2729632a0908241450m1651c77ata9744058c5d42672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 23:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfhRk-0005GU-PV
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 23:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZHXVun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbZHXVum
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 17:50:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:51283 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbZHXVum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 17:50:42 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1488078qwh.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=uSiQFYHujgmA8k1V6/QJgcu8Vr+Wa5mrT1PThH9LIyM=;
        b=Wf/bNe/22W8L2XQatt577iCHdRSsjS5pGLBUwFnnVwI0/hM4oPRJanhNnvZ8IuA/3V
         HqDJjiylOgmRWj8wh4/aI0XZQSkGZaPI17+VUT7IgHsj9tnVYCIwcGTOjOVO999cUBee
         mXvu2fcNxwu/ER3LcwDrFFhpA2pn3SG91j6vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nnk0dEHQBABm4//8ukSZdLFnzcf5MtouODH49pwLwFt7cNC4svmfop3OOtstBZ3Yb6
         AbqFCJWbQhS144ARivLgERR1TcXPjucWbO3So+TtsJQVgh8etWxqPXJ5Y9NjxMtgzPJG
         XI8Ctg63SrArhxUrv2snvCHun1tDLs0laDb/Y=
Received: by 10.224.50.81 with SMTP id y17mr2421556qaf.109.1251150643716; Mon, 
	24 Aug 2009 14:50:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126973>

Is there a way to list the files git considers binary in a repository
(and alternatively, the ones it considers text)? I have a large
repository and I want to fix line endings for text files that were
accidentally checked in using CRLF and can't just use the file
extension alone because some files with the same extension may be
binary and others not (e.g. UTF-8 .strings file is text, but a UTF-16
.strings file is binary...git already figured out based on the content
that one is binary).

I thought maybe git ls-files, but I didn't see anything in there I can
use for binary vs text.
