From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] api-trace.txt: fix typo
Date: Tue,  5 Apr 2016 10:05:23 +0000
Message-ID: <1459850723-46974-1-git-send-email-gitter.spiros@gmail.com>
Cc: karsten.blees@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 12:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anNrq-0006gZ-Md
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 12:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921AbcDEKFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 06:05:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33553 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbcDEKFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 06:05:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id i204so2793843wmd.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8Y3lhtAZ5gJuRlnx0JjQvSmQs/WRi4PJ5rdnn2NG5Bc=;
        b=oe7+z23PCjdaTJ/a+hH9cdA0dY25/3AGFMs0LB3UNZG89dIM25aBYm1D27CPv7Af54
         646Y+YZds1OMNLCFr5FXSh0ZqXalOAbZ0P79/oP1UGzVi4NEe0netBQKAvFQydxiNCez
         aqy7H/q2O0tx0Co3aoTozvRxtYyLQojEupGsyIOdSUMw0JUiK3/tOUlq5JKFRVRuZX/N
         svRiTakiWNppK1iHU/yY7dfV5AZoZWEnubFlpeHYCbQjZkW2OAE91rkQi66V+FM/4Kor
         zR/AP2FNDnzRc1cN0qt2WmNayRSpkQK2bTAC2bPAAfMZRyjSLUlpHxdOiqvqIG23Zeap
         l7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Y3lhtAZ5gJuRlnx0JjQvSmQs/WRi4PJ5rdnn2NG5Bc=;
        b=FwWwpvq+PklNAuR+eAALmI/CB3CzTjaZdJ5LeoaFr1bIORzkA5fhKv1Tskmt3RCqoa
         MnSwFnyUf30tiU7WcatgTwtGIc9ePZMtKvoZZvPG4KKuUDipL6QOPHK5PzVFDLO/zGsC
         1H4QAMwqqrbAhOe2X+w6f0X9ux/sLnYCL6HGDR0G9Yl5cYoYIL0U/fdBBM50bmuipnfw
         +9wJrklT/EGa9XljXc600sBjrVbZ9xS60F23lJZlInCRi39+QaExBPFgEhGCEvZKvmyE
         zW4zn+7y8vY35AEHXUc+MYTysVDqzHc+AsnsIECTP4xT9Ohc4KAtF3dvHKMKvzF4DiWN
         qtfA==
X-Gm-Message-State: AD7BkJIif+oiB/Wo5lMDDx6kYzTlDJMHAvTtcOcnUZkNm+5wioJnzznS0K/zyfLhLT9gww==
X-Received: by 10.194.122.138 with SMTP id ls10mr23187168wjb.51.1459850733691;
        Tue, 05 Apr 2016 03:05:33 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id j18sm18718559wmd.2.2016.04.05.03.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 03:05:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.270.g9d4de1f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290770>

The correct api is trace_printf_key

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/technical/api-trace.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
index 389ae16..45a0ecd 100644
--- a/Documentation/technical/api-trace.txt
+++ b/Documentation/technical/api-trace.txt
@@ -28,7 +28,7 @@ static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
 
 static void trace_print_foo(const char *message)
 {
-	trace_print_key(&trace_foo, message);
+	trace_printf_key(&trace_foo, message);
 }
 ------------
 +
-- 
2.8.0.270.g9d4de1f.dirty
