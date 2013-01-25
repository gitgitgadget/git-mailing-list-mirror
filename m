From: =?UTF-8?B?0JDQvdC00YDQtdC5INCR0LDRgNCw0L3QvtCy?= 
	<andrej.andb@gmail.com>
Subject: Separately repository access in GitWeb
Date: Fri, 25 Jan 2013 15:10:43 +0700
Message-ID: <CAJjU7bS-rRr-UuEA_xcqtTY4+tWKshL+Rvey85n70KacSnTorQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 09:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyeNO-0001KO-PA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 09:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3AYIKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 03:10:46 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:58680 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3AYIKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 03:10:45 -0500
Received: by mail-oa0-f53.google.com with SMTP id l20so82578oag.40
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=mime-version:x-received:sender:x-originating-ip:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=CFuxo2Durxjq43THh8X3C1HeGNvweoiZmizCUJXOocE=;
        b=PpqhBqnujN+NnEF38tlK0qEJcD18WhIT4cwxjPKiZ0KRo1Xn0Mx++MDMubDluBbB+7
         TbLmGvt2bSIivM8bsoBQc79pfFxnThIKOvtSVhqYvt2dowihas1mrBByG0Tn+MQnvFQP
         btIn9MXsv5+FDY8KCidWdq/r+jgU1cwJwDWfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:x-originating-ip:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=CFuxo2Durxjq43THh8X3C1HeGNvweoiZmizCUJXOocE=;
        b=r/6+Wyymu2yIW87W+DnxgSGrZ8ZY9lCeQdu14Q4JG0KkrUXOoyZSlnTbIFa+zBixn9
         AHyJIXgVtFcKAWWB1N+9sVPm7vpdfBWhcftejnqwViNY49nLtq/Sd6U2q32b2HuvatXI
         xkLp2qxraXzzKnt4cLyYx31cFQzvFBHXxBcLoeaUlI9ePI1h1bukJ9qF4plX7V2+QbY2
         id4WnmmSk9oqdu4TZmaWwJaqGTrXqdC/ZV/swjybWU+s/dlYfU8GUuAk5rMl3HFPBj7w
         N0A4xXrX2kt5siI7bZMWXKdTaXyUxtzOHRrS83q/LY/jKzrixr71uxRdt3SiD9wapuQb
         7d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:sender:x-originating-ip:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=CFuxo2Durxjq43THh8X3C1HeGNvweoiZmizCUJXOocE=;
        b=EoKzemqKDUTG34n7pGEKvFp3GEojLkhtF/L/NW+XsPoIamyTsqpCPPH6j9wzmdTr7H
         huM76PRRSe6BeilYFy1A6ucEsGt6R/z8kYeYaISuk7FzmcgVHJYpm+GRgzsNGJUMqBn7
         TDwte08DmfAV/tQ/bHrykNSrayR3tY9sZnHP70HSM2UlkgcHy22+PrtWng5rMPpBGysi
         Pc9aESXelfCyQehCaQeFj/OChuu/tDhtCfa0fVSBIzywd0qMfw63WgsLmehAddXGsiBl
         B/wCKyN9uHo55Hcrvui9bEer8axULM+i3yvX9ssAkIrL9SYHZUyDVzhIExs0BJHtli34
         HBRQ==
X-Received: by 10.60.3.193 with SMTP id e1mr3964802oee.39.1359101444023; Fri,
 25 Jan 2013 00:10:44 -0800 (PST)
Received: by 10.76.9.35 with HTTP; Fri, 25 Jan 2013 00:10:43 -0800 (PST)
X-Originating-IP: [90.188.9.189]
X-Google-Sender-Auth: Sie-Wc7FAAPoH839T4zVuc7AjlA
X-Gm-Message-State: ALoCoQk5MNA4TgwYMXdb0vZB9FmlNOSJGp+tAbP9rhiMbgfA5Eh/2HXT245kccx/R5U5tTp0Q/sl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214512>

good day.

I`m trying make separately repository access in GitWeb by NGINX

separation of access based on URL strings, namely, the presence of the
query strings:
'?p=repo.git'
with a regular expression:
"^.*p=(.*?)(\.git|;|&|=|\s).*$"

I am wondering how much it is correct to protect against unauthorized access.

Thanks in advance :)

complete example of a configuration file:

server {
        listen 80;

root /home/git/gitweb;

        access_log /var/log/nginx/gitweb.access_log main;
        error_log /var/log/nginx/gitweb.error_log info;

        index gitweb.cgi;
gzip off;

    location ~* \.(jpg|txt|jpeg|gif|png|ico|css|zip|js|swf)$ {
access_log        off;
        expires 1d;
    }

    location = / {
set $htpasswd "opened@";
if ($args ~* "^.*p=(.*?)(\.git|;|&|=|\s).*$") {
set $htpasswd /home/git/.gitolite/conf/$1_htpasswd;
        }
        if (-f $htpasswd) {
                rewrite ^.*$  /closed last;
        }

rewrite ^.*$ /guest last;
    }

    location = /closed {
internal;
access_log /var/log/nginx/gitweb-closed.access_log main;
auth_basic "Unauthorized";
        auth_basic_user_file $htpasswd;
        include fastcgi_params;
        fastcgi_param  SCRIPT_NAME gitweb.cgi;
        fastcgi_param SCRIPT_FILENAME /home/git/gitweb/gitweb.cgi;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
    }

    location = /guest {
internal;
access_log /var/log/nginx/gitweb-guest.access_log main;
        include fastcgi_params;
fastcgi_param  SCRIPT_NAME gitweb.cgi;
fastcgi_param SCRIPT_FILENAME /home/git/gitweb/gitweb.cgi;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
    }

    location  / {
        rewrite (.*) / permanent;
    }

}
