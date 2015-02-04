From: Louis BAYLE <lbayle.work@gmail.com>
Subject: Fwd: [BUG] dos2unix converts french accents to NULL char
Date: Wed, 4 Feb 2015 17:00:27 +0100
Message-ID: <CAD7Fce_60W=LvdhyW-fwEqzWnerC6WwV3Sw8VLct08LqDdrTJg@mail.gmail.com>
References: <CAD7Fce8vwrAZL-gh9a7530Tr=z=fpmqfOAdSMH7u4Jc_Odespg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bf0e208817067050e454adf
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 17:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ2Nr-0002ky-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 17:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966072AbbBDQAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 11:00:50 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:38410 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355AbbBDQAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 11:00:49 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so1891883qcx.4
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=9xEMSyBwKXLOVpYTUnO5OC+/9cSBx0E/9xqnT7OqZhM=;
        b=NpKIxGhUALXl8e9+xerJ2lkSH0zGXEPqg7NNKu5uC1uA+jecVJ74gqMtUt3c/vQ5H5
         lulrP/4GADDLTXfdiMvWHXoDOcavVG1NkWWDqNahgTnwcx2dKJdzvJEloBIyKjXgZ4e6
         95yUHrC5mOxTIb2RexduuAjF/1RzaaU1h32Rlb/LsX7Liwld8EuFm9U14VwgwRQgyacH
         iF8xqOBa/dgnS1MhFreOP7n0YvgnZJ717XqpzBEjiCkF83ckq8FUtCaDbH76qoG5HSpj
         4Rc6erRzRmync1GKG/spFalyfHF3zDdGPaI4JhCNqBFrTG7ar0HoNEi5/JN6bGMzCkhM
         CxvQ==
X-Received: by 10.224.55.71 with SMTP id t7mr65968591qag.53.1423065649058;
 Wed, 04 Feb 2015 08:00:49 -0800 (PST)
Received: by 10.96.216.42 with HTTP; Wed, 4 Feb 2015 08:00:27 -0800 (PST)
In-Reply-To: <CAD7Fce8vwrAZL-gh9a7530Tr=z=fpmqfOAdSMH7u4Jc_Odespg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263352>

--047d7bf0e208817067050e454adf
Content-Type: text/plain; charset=UTF-8

Hi,
I'm using Git for windows version "Git version 1.9.5-preview20141217"

when converting a text file with unix2dos.exe or dos2unix.exe (via git bash),
the files are corrupted if containing french accents.

as attachment, source and converted file after a dos2unix.

Note: the following library does the work correctly:
sourceforge.net/projects/dos2unix/



Louis BAYLE
Tel: +33 (0)4.42.604.734
lbayle.work@gmail.com

--047d7bf0e208817067050e454adf
Content-Type: application/zip; name="git_unix2dos_error.zip"
Content-Disposition: attachment; filename="git_unix2dos_error.zip"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5qwewij0

UEsDBBQAAAAIALiGREZROqyt5wAAABkCAAAZAAAAU1ZDTVNHX2FmdGVyX3VuaXgyZG9zLnR4dK2R
MU/DMBCFMyPxH24sXeI0SJBKDG0SlQjaVAlUYrTco1hqnOji8Pux3SJDlw7tW++795594DSGp4sE
49ubX6e0XH/AUVOoN+myXvhphr0g2WnZKjvVNAg9EPbQtQPBngOhGLqAuCO2dsCJN4E2jHf5J0NB
j/QthaFRwWuxepktcqjz9K0oV3+aUeBsD80m9yGLwyhJEhg9z8v3Ow8u2638lMLBU4gjC04Yi2G0
tqBZrrBpuj0X2KDS9pF5Vdmm4E3Oq9jMzN+wyO+cJLOHkD0ek+dZkdlk8cXV7hBL6DpItTOx1z7k
D1BLAwQUAAAACADkhkRG74hWP+kAAAAZAgAAEwAAAFNWQ01TR19leHBlY3RlZC50eHStkcFuwjAQ
RO+V+g97pFzikEptkHqAJKJRC0FJi9SjZbbUEnGijdNvLn9R21C5cOEAc923M2MvOA3h6SLB8Pbm
zykplh9w0BiqVTKvZn6aYidItlo2yk419UL3hB20TU+w5UAo+nZH3BFrO+DE6x9tGO9yJENBh/Qt
haFRwWu+eJnMMqiy5C0vFv+a0c7Z7puN7gMWBWEcxzB4nhbvdx6cN2v5KYWDxxCFFhwxFsFgaUGz
XGJdt1susEal7SOzsrRNwZucV76amL9hod85SWYPAXs8JE/TPLXJ4ourzT6W0HWQamNir33IX1BL
AwQUAAAACACthkRGhlSUvecAAAAQAgAAEQAAAFNWQ01TR19zb3VyY2UudHh0rZHBbsIwEETvfMUe
KZc4pFIbpB4giWjUQlDSIvVomS21RJxo4/Sby1/UNtQVXDjAXPftzNgLTiN4ukowGvwZJcXqA46a
QLVOFtXcD1PsBMlWy0bZoaZe6J6wg7bpCXYcCEXf7ok7YmMHnHj9ow3jTU5kIOiQvqUwMCp4zZcv
03kGVZa85cXyvxbtnemh1vg+YFEQxnEMw+dZ8X7nuUWzkZ9SOHYCUWi5MWMRDFeWM7sl1nW74wJr
VNo+MCtLWxO8x2Xl66n5Fhb6lbNc9hCwx2PuLM1Tmyu+uNoeQgldA6m2MLjxAX8BUEsBAj8AFAAA
AAgAuIZERlE6rK3nAAAAGQIAABkAJAAAAAAAAAAgAAAAAAAAAFNWQ01TR19hZnRlcl91bml4MmRv
cy50eHQKACAAAAAAAAEAGACxIvDCkkDQAbEi8MKSQNABQf+wuJJA0AFQSwECPwAUAAAACADkhkRG
74hWP+kAAAAZAgAAEwAkAAAAAAAAACAAAAAeAQAAU1ZDTVNHX2V4cGVjdGVkLnR4dAoAIAAAAAAA
AQAYAFG/dPKSQNABQZh08pJA0AGR7fnRkkDQAVBLAQI/ABQAAAAIAK2GREaGVJS95wAAABACAAAR
ACQAAAAAAAAAIAAAADgCAABTVkNNU0dfc291cmNlLnR4dAoAIAAAAAAAAQAYAGHqEbaSQNABwcP4
Y5JA0AHBw/hjkkDQAVBLBQYAAAAAAwADADMBAABOAwAAAAA=
--047d7bf0e208817067050e454adf--
