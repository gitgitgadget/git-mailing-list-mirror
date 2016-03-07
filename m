From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: More configuration options for some commonly used command-line
 options
Date: Mon, 7 Mar 2016 17:37:10 +0530
Message-ID: <56DD6EEE.4030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 07 13:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1actwb-0003HS-8U
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 13:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcCGMHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 07:07:16 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36186 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcCGMHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 07:07:14 -0500
Received: by mail-pa0-f54.google.com with SMTP id tt10so15942310pab.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=3Gh1FgViTS58Y6frUoB+Ey3WL90AJntZ+nl6JoE2mtg=;
        b=UO+sE7LyN+YOyr+mcPmNrlhxRXLrTOE5pNrGTGPM0somjDmGT3mNmoPkILItYzf7fd
         Jdg7Ouh+Ym8pTU/lYCFJ6MEexLI5Ftv9RkzM5Urj1axsDdIHqCS8QiphSa0sGA33kNBP
         fyTPoG7SemLVT4Z5zMKGgkAejAX/j0uUzbEvyXI5ZwNRmQRYCNkAB2/yfJqgqzlPkJd9
         Cyyi+y0aIz33ljTCyvtwJcwETnE6RXcC58XUa+bCwHZ8qJB3I/SW8H+eOLX3i+Ly2EEj
         JrPeVIsL/2MVKZUccMPH9ZszhATqVfuV9p8fH9/MMCwShwLlOTjkHNziyb2sDCPSoowU
         r2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=3Gh1FgViTS58Y6frUoB+Ey3WL90AJntZ+nl6JoE2mtg=;
        b=iqQUzVv6LcNkIqUoFenxJYwdiBmOHgmSqV5roemSq0SVnIVUE6YMCoNVoX+K2uIlmc
         Kzv1dD3yorDMZz+3DQtZ6/lr+UHPECXKjBK1c1u/gQIBhn09/aWFeMzAGal71u2viQVC
         9meJElPlPGppHd5T6hv0+gtoxuF55eg6ZP+wBMzQl6+6oaExemIt1jz3eEaxkBa81oVJ
         +Q06Bxx/a78LLLzB6bF870p7wlIVSF1QzVImzT8eCiY0rubw2AQpl17kbZ7ZaNB2t4Eq
         JHReeu34FJcx+Nopyv4Yqw7wGnFt1VvyHOPA+tjROu29w8AYCJjJY5jswAhwCMOvXyLZ
         VldA==
X-Gm-Message-State: AD7BkJLoV3joXe4Rmst/6C8Bb7Af4aHJwPtZlJXBNvm3yJTRo1KuxksBUMpcBG/gcIM2eg==
X-Received: by 10.66.97.101 with SMTP id dz5mr32857030pab.61.1457352433869;
        Mon, 07 Mar 2016 04:07:13 -0800 (PST)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id w12sm23771330pfa.79.2016.03.07.04.07.12
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2016 04:07:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288388>

Hi,

Regarding the GSoC Microproject 'Add configuration options for some commonly
used command-line options', currently the list [1] mentions only
`git commit -v`. Can the following also be candidates for configurations?
* git log -p
* git remote -v
* git branch -v


Regards,
Sidhant Sharma [:tk]


[1]: https://git.github.io/SoC-2016-Microprojects/
