Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1AD2042F
	for <e@80x24.org>; Tue, 15 Nov 2016 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbcKOS0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 13:26:39 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35496 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbcKOS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 13:26:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so2740692wme.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9fkqEv6OZNXz+82RDSoVm/D18giiHzLfEN8E2rZ4Z8E=;
        b=v67EBotqjV3KSzB8DnHcAq2BT0I9ewusYDuSOBxJo7H/E32suAdznfB47kZWX4z9ue
         vczKMEavj9aiFu/SUkY3BQQxHiOPI9CBmyUakpZEtRifLgRsE2IFUUA4XAPKpmGjQZXS
         5ZlmXmfOCwuC71Zot3TxqGfpQo/XAoLfRasrSr3qAK/Do5gEb1MZbxW9JxLtk6KOVziw
         XDNosBFbilfRhX8O/zT2j7BEfMcSu4QQxiYtmvtkIFiFC09qKYxEYLCiZ+/+vE9mrbZR
         0kk6V9hoxty9j8npcxzA/WeKuQsfegBHvct2Lv3gB8OD6IHK6vGDxKizAfYxPjQG3IiL
         m33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9fkqEv6OZNXz+82RDSoVm/D18giiHzLfEN8E2rZ4Z8E=;
        b=PhwmBSAPCy6A4jEQQUjFpsKwBHzkrPMAp5oAts4gV3AVnuE8/7qqxDDV73V7EBmQuW
         BF5g/MMS3cZ0BqdK0BMF+Qkw6vYYrlMAo0INAXyd2BVQXZwJZfAGD9i6pk15Pqtf5XDZ
         Y+yJrbvtFNBlJQLkEXEUV0lyem628qckWd9vDcqlT9sNc4lTfbrBrGIAdsjcaHBFNTYC
         vJG6GoWalk1l8iBSzz6+TtIpryLRNoDWlI4jS+xAAooGEiOwXerqDMsHUjWW0HXc6rTU
         4+sud0K0fUyLh3MqIwy0LV7gVyOGX400B8ncH41p0ezSFG5V6uHk/Nu2bJjJayPa3Wu2
         81Ow==
X-Gm-Message-State: ABUngvcB/HgkDgP6+zm6dEKJvGlv0qwnRYc70xjfujH8Xy9v5j34xBEJIK3upDNFRbBehw==
X-Received: by 10.28.51.141 with SMTP id z135mr4891603wmz.109.1479234394606;
        Tue, 15 Nov 2016 10:26:34 -0800 (PST)
Received: from localhost (cable-82-119-17-132.cust.telecolumbus.net. [82.119.17.132])
        by smtp.gmail.com with ESMTPSA id kp5sm8656547wjb.8.2016.11.15.10.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2016 10:26:33 -0800 (PST)
Date:   Tue, 15 Nov 2016 19:26:32 +0100
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     =?iso-8859-1?Q?Rapha=EBl?= Gertz <mageia@rapsys.eu>
Cc:     git@vger.kernel.org
Subject: Re: gitweb html validation
Message-ID: <20161115182632.GA17539@gmail.com>
References: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raphaël Gertz <mageia@rapsys.eu> wrote:
> Hi,
> 
> There a small bug in gitweb html validation, you need the following patch to
> pass w3c check with searchbox enabled.
> 
> The problem lies in the input directly embed inside a form without a wrapper
> which is not valid.
>

I agree this is a small bug. Only block level elements are
allowed to be inside form tags, according to
https://www.w3.org/2010/04/xhtml10-strict.html#elem_form

> Best regards
> 
> The following patch fix the issue for git-2.10.2 :
> --- /usr/share/gitweb/gitweb.cgi.orig   2016-11-15 15:37:21.149805026 +0100
> +++ /usr/share/gitweb/gitweb.cgi        2016-11-15 15:37:48.579240429 +0100
> @@ -5518,6 +5518,7 @@ sub git_project_search_form {
> 
>         print "<div class=\"projsearch\">\n";
>         print $cgi->start_form(-method => 'get', -action => $my_uri) .
> +             '<div>'.
>               $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
>         print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
>                 if (defined $project_filter);
> @@ -5529,6 +5530,7 @@ sub git_project_search_form {
>                              -checked => $search_use_regexp) .
>               "</span>\n" .
>               $cgi->submit(-name => 'btnS', -value => 'Search') .
> +             '</div>'.
>               $cgi->end_form() . "\n" .
>               $cgi->a({-href => href(project => undef, searchtext => undef,
>                                      project_filter => $project_filter)},

I think it's better to just move the <form>-Tag outside of the
surrounding div?
Something like this perhaps, I didn't test it myself yet.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7cf68f07b..33d7c154f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5531,8 +5531,8 @@ sub git_project_search_form {
 		$limit = " in '$project_filter/'";
 	}
 
-	print "<div class=\"projsearch\">\n";
 	print $cgi->start_form(-method => 'get', -action => $my_uri) .
+	      "<div class=\"projsearch\">\n" .
 	      $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
 	print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
 		if (defined $project_filter);
@@ -5544,11 +5544,11 @@ sub git_project_search_form {
 	                     -checked => $search_use_regexp) .
 	      "</span>\n" .
 	      $cgi->submit(-name => 'btnS', -value => 'Search') .
-	      $cgi->end_form() . "\n" .
 	      $cgi->a({-href => href(project => undef, searchtext => undef,
 	                             project_filter => $project_filter)},
 	              esc_html("List all projects$limit")) . "<br />\n";
-	print "</div>\n";
+	print "</div>\n" .
+	      $cgi->end_form() . "\n";
 }
 
 # entry for given @keys needs filling if at least one of keys in list
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 321260103..507740b6a 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -539,7 +539,7 @@ div.projsearch {
 	margin: 20px 0px;
 }
 
-div.projsearch form {
+form div.projsearch {
 	margin-bottom: 2px;
 }
 

