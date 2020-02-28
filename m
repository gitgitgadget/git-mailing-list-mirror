Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B598C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2C2469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Bex3b6BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgB1PQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:16:01 -0500
Received: from forward104o.mail.yandex.net ([37.140.190.179]:41619 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgB1PQB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 10:16:01 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 10:15:55 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 17B38942156
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 18:07:49 +0300 (MSK)
Received: from mxback8q.mail.yandex.net (mxback8q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:b38f:32ec])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 13D9561E0009
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 18:07:49 +0300 (MSK)
Received: from vla3-4c649d03f525.qloud-c.yandex.net (vla3-4c649d03f525.qloud-c.yandex.net [2a02:6b8:c15:2584:0:640:4c64:9d03])
        by mxback8q.mail.yandex.net (mxback/Yandex) with ESMTP id rEYbjAWGcX-7nIGqTDe;
        Fri, 28 Feb 2020 18:07:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1582902469;
        bh=vHUzBYhmsmV1QLVWlcCFa95Q+ZEU2Cq8wt9GGprwSVk=;
        h=Subject:To:From:Date:Message-ID;
        b=Bex3b6BM0kC7bvQa1KcnMLCDQBb2KulNjfwvdZd1wiT5N3JW6CJO2Ytdxf3zk0fzn
         RlfOOdURwJbCGwXdXWJxogQwyMTxMNJb4i9+ENylkj89+rmhfhlHeUY5KDJXFrortM
         FxeAsAWgf/wuYB3soWltBZelw+3z2RuveRN0f5tM=
Authentication-Results: mxback8q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla3-4c649d03f525.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3wK33CDCrk-7ljif4wb;
        Fri, 28 Feb 2020 18:07:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Fri, 28 Feb 2020 17:07:47 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1511855819.20200228170747@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Commits are market as < but I expect = while git push --force
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git team,

[alias]
    changesfull =3D log --graph --decorate --pretty=3Doneline --abbrev-comm=
it --cherry-mark --boundary --left-right
    tree        =3D log --graph --decorate --pretty=3Doneline --abbrev-comm=
it



from here we can see that **commits are euqal**

| =3D cf379600 add fixed captcha and copyKey
| =3D b9675add Display suspended packages
| =3D aaa61c87 Fix sub name
| =3D fea1588f Display status for suspended package
| =3D 1744b66c FIX: Use of uninitialized value $value in concatenation (.) =
or string at ...
| =3D 44fe0adf Remove excess parameter
| =3D dc3348d0 Fix condition
| =3D 14d866d7 Allow to connect to raddb
| =3D 85269f84 FIX: compiller automatically adds .exe
| =3D d1492746 Check that user exists



kes@work ~/s $ git changesfull 8ad1a35b...afacb2ab
< 8ad1a35b add form_section
=3D 0d42d957 add fixed captcha and copyKey
=3D 89d448f1 Display suspended packages
=3D c4b2eb0f Fix sub name
=3D 88151d09 Display status for suspended package
=3D d049b926 FIX: Use of uninitialized value $value in concatenation (.) or=
 string at ...
=3D ecc644d4 Remove excess parameter
=3D 305f2cf8 Fix condition
=3D ade88b4b Allow to connect to raddb
=3D 91d1699f FIX: compiller automatically adds .exe
=3D b83f1394 Check that user exists
| > afacb2ab FIX: "my" variable $user masks earlier declaration in same sco=
pe at ...
| > 77e834bb Admin menu in alphabetical order
| > 3bdfdfb1 Allow to configure Grafana domain for statistic
| > 382b5014 I do not know port for custom config
| > 9fc7a9c6 Use 'bridge' mode by default
| > 94ba81eb Changes in the address staff -> cabinet
| > bd742589 Fix problems when user opens link at multiple tabs
| > 257dcef4 Configure ContactUs variable
| > 5ad4822f Reduce level acces for ContactUs form
| > a553700b Fix variable name
| > 143d8975 Force mailing for new order and registration purpose
| > d1e3477c Rewrite condition. Add logging
| > 34392eff Log more
| > 97047ffd Log message when email was sent
| > 98255b99 Fix template name
| > b1469892 Reduce right requirements for remind form
| > 6e2006ae ID is not requred for registration
| > f54b638a Change flow how registration and ordering work
| > 8a75a742 Use &debug instead of hardcode check
| > 5d629de7 Create order from session data
| > 0e2e7506 Implement new configuration option: activation_hash_length
| > b5bf701d Prevent deep recursion when calling App::config
| > b10ef0d1 Security note
| > 8835655d Implement T_INSECURE function to allow calls to ->create
| > 1ecfeac9 Allow to export &log
| > 2c89558a Do not pass whole object. Pass just required info: email
| > e33af63f $c->uid is called at previous expression
| > 0686758a Ask mail for ordering
| > 05e7ed08 Do not display cabinet menu if user is not logged in
| > db03226c Display for logged in user more text
| > 500b856a FIX: Missing or empty input at ...
| > 83230f35 Imlement utility to easy work with database
| > d65148d8 Pass 'role' explicit
| > 5f1a57b6 Add key expiration for Redis
| > bc5850dd Simplify code
| > a850b734 Improve helper functions
| > 2244724d Security note!
| > f48ad97a Implement helper to work with Redis
| > e31f2e6c Install Redis
| > e27c03a5 Changed the display of creating PayPal invoice
| > 47286618 Adding App :: Do to Controllers
| > 409447c9 Rework routes
| > 45de583d Hide menu if user is not logged in
| > 5a5eb2b9 Update password for current logged in user
| > 359b66b9 Add $user parameter
| > 4a522108 Use short description for manual invoice
| > 2e2ff2c3 Fix spacing
| > b2b5b16d Typo fix
| > 8a6c921d Do not try to find tariff for manual invoice
| > ae59ef57 Filter invoice duplicates
| > ac5bc0da Move comment
| > 2fd9c87a Fix registration link
| > 18559b63 Added order information (ip, country, city, browser)
| > fdb0f70d Active display in listener / show template changed
| > 73261cd5 Changing the creation and editing of a listener
| > a0fddafd Changing validator parameters in a Listener controller
| > ae5f6796 Put correct quoting
| > 0149b316 Fix display message
| > f4e33cbe Implemente del_stat for Grafana
| > 42d5af8a Prettify error message
| > 67da86de Invalidate link after password is set
| > 6ac55a49 Remove STAGING mode
| > dd5a02c5 Fix openvpn generator
| > 1e2cadf6 Force :id for user
| > 9fb16671 Fix authorization
| > 4882698d After user creation $user->D returns undef, but should return =
default {}
| > 333de78a Remove two factor
| > 88c81aac Fix spelling
| > 5616133f Rewrite order process
| > 328fed71 Do not try to find undef values
| > bea391f9 Remove wizard
| > b6c75889 Display email in change password form
| > b3769ecf Fix text
| > 0cc7a880 Makeup form option form sub
| > 1ad64a7a Rework change password process
| > d58c69ca Rename template
| > 509f83b5 Fix text
| > b55fca77 Template rename: remind -> link_sent
| > 62eed3c6 Renamed: set_options -> save_cart
| > 0169cb67 Display verification link in development mode
| > d8e3930c Renamed: $g -> $self
| > 61cc36d5 Put grafana keys together
| > 4c007e84 Function =F1reation delete_user
| > 40d2caa2 Typo fix
| > 2dbc6262 Store grafana datasource and user id for user
| > cc79b4bd Added drop_influxdb
| > c5e15f76 Implementing the Terminate Function
| > c681beae Fix class for links
| > 6afaf67b Fix call
| > 7b1eae08 Temporary disable 'Request late payment' button
| > c57c8bd5 Fix link to PP invoice. Now it is highlighted
| > bd115260 Fix due_date for PayPal
| > 0c1d0414 Fix order by admin
| > af00c1df Use 'bridge' mode by default
| > 7eaf74ad BUG: Do not send fwtag if firewall is OFF
| > c8d7c603 More checks for error
| > a8958e88 To reset vpn keys we just create new account
| > 36772ffe More logging
| > 4edb5e16 Provide names for arguments
| > 4c705c99 Implement global logging variable
| > 0b817b04 Disable connection cache
| > 0fad0bfb FIX: Use of uninitialized value in lc at ...
| > d7842855 Fix route name
| > 0826d061 Use dispatch table
| > 38eac024 Fix call convention
| > 286bb9e8 Fix manage page
| > b6d07840 Fix values
| > f8f8fb3f Restrict access
| > 17ce2324 Use new interface to lookup listen_ip
| > c0807de3 Improve error message
| > 7cc32b3e Remove detect_listener in favor of $package->listener_ip
| > b5ac1176 Return own address or take default from server
| > 7cae0c67 Look listeners by tariff type
| > af6f7af1 Move code into its own sub
| > 940f53c3 Hide Options in production mode
| > 722d7043 Do correct error reporting
| > 842b1c54 Display error message for admin
| > 7d9575c3 Add graphana template to the repo
| > dd03b23c Fix path to graphna file
| > 60ed9f9e Select additionally id as workaround
| > ad2f69df Localities editing in order / edit template
| > b1b1efd0 Correcting the display of parameters in the order / show templ=
ate
| > 551ad717 Passing a parameter when ordering a package
| > 90ac72e2 Hardcode removed
| > 0c3c90b9 Ability to select only active localities
| > 1fe503e6 Move category/sub_category into its own subroutin
| > 9adc0948 Fix problem with select field
| > fa492730 Make Server tag not required
| > e191fe98 Do not do changes at Mojolicous modules
| > 3ded8b0d Add webhooks for GoPay
| > 9172465c FIX: Undefined subroutine &App::Util::register_state_mapping c=
alled at ...
| > 447a4292 Fixed canceled to cancelled
| > ad3f99a7 Replacing Cancel with Back
| > 4c97ec4c Changing brackets in a query
| > 85bca306 Locality in order template
| > 3a0beb4a Changed state display in Order
| > bc5b1a69 Changed state display in Package
| > eee04065 Changed the mapping of state to IP
| > 4934e0de Split mapping hashes by type
| > 087a1e69 Fix Checkbox
| > 0be542fd Implement state mapping
| > a4e15cc1 Disable gopay in production mode
| > 33d0b44d Fix configuration value
| > e74c1c86 Move excess config from stagings
| > a2ec2bb0 Do not try to display link to order for manual Invoices
| > 5d1859b8 Inherit {mountpoint} from main configuration file
| > fc8948b5 Use new contacts
| > 23b0f3bc Fix key on l2tp_key
| > 7ba61f44 Adding and removing nas_ip and listen_ip in the Server table
| > aacd3365 listen_ip is not created
| > 16fb5b82 Fixed key on l2tp_key
| > db21c2cc SCHEMA 102: Duplicate listen_ip and nas_ip in Server table
| > 51db2dee Button color change
| > 66577eb4 Implemented removal of listener in server template
| > 95e5b893 Implemented adding listener in server template
| > d152d2fe Editing a listener from a server template
| > 8884331f Pass related table directly
| > 78cd4b6c Fix checkbox invoice
| > ad6d29e3 Add Grafana configuration for prod
| > 48505a48 FIX: Can't locate object method "listen_ip" at ...
| > cd5921f3 Fix template path and replace text by actual values
| > 4a0004d1 Link to grafana stat
| > 08becf0b Create grafana stat automatically
| > 91c094c6 Create new package API
| > 73264a30 SCHEMA 101: Add options field into User table
| >   19b6f122 Merge remote-tracking branch 'dash_v3' into dash_v3
| |\ =20
| | > aec9930b Implemented output and saving of the name field from the Ser=
ver table
| | > e22df3cf SCHEMA 100: Added column name to Server table
| | > 72baca16 SCHEMA 99: fix server constraint on IP
| | > 78bc4523 Saving ip in server table
| | > 926cc240 SCHEMA 98: Table Server. ip_id to ip
| | > 71345a1d Moving DNS keys from Subnet to Server
| | > 5bd6103c SCHEMA 97: Moving DNS keys
| | > 79649d18 Added checkbox active in listener templates.
| | > 4997c195 SCHEMA 96: Added Active field in Listener table.
| | > c5855ca4 Implemented saving keys from CONCONFIGS
| > | b93f0317 Init variable with application root directory
| > | cb7b0e1e Move App::Do::config into App
| > | 8878d495 Create grafana dashboard for given folder
| > | 34b62277 Create template with variables for grafana dashboard
| > | c49f24e0 Optimize code a bit
| > | ac391135 Send UID only for cmd of type 2
| > | 8bec1d57 User MUST be lowercased
| > | b793888d Select first parameter only. Fix syntax
| > | d6cf2108 Revert "Put txid at the end of command"
| > | 1d42e76a Revert "Typo fix"
| > | 3f945dae Connect to correct NAS server
| > | 4301edc4 Limint usertag by 10symbols
| > | 120e0250 Typo fix
| > | 4a81c77d Put txid at the end of command
| > | 9fb20d38 Pass flag to generate new port or not
| > | 23fdc513 Return $listener:$port
| > | af43241f Fetch listen_ip and return it
| > | a1bcfb14 Do not forget to load module
| > | 94ada113 Be more strict. Declare variables
| > | ff1898ea Call method instead of direct access
| > | 93838043 Create folder via Grafana API
| > | 96997eab Implement other subroutines
| > | 22da80e5 Use grafana plugin
| > | a06ab4a7 Grafana does not allow to create users using token
| > | 8f4e6666 Implemented basic functions to speak to Grafana API
| > | f030c245 Changed scp to rsync
| > | de662afc (tag: v1.0) Fix configuration files
| > | cda5e0c6 Do not display 'config' option for PPTP/L2TP packages
| > | 32a0d87d Get correct listener IP for different tariffs
| > | cb18e74c Move captcha to login form
| |/ =20
| > 412bff9f Fix template
| > 38ceba41 Refinement of display of openvpn tariff data
| > 95d00f9f Fix Options
| > 21764a1e Captcha
| > cf153349 Implemented ssl_key saving
| =3D cf379600 add fixed captcha and copyKey
| =3D b9675add Display suspended packages
| =3D aaa61c87 Fix sub name
| =3D fea1588f Display status for suspended package
| =3D 1744b66c FIX: Use of uninitialized value $value in concatenation (.) =
or string at ...
| =3D 44fe0adf Remove excess parameter
| =3D dc3348d0 Fix condition
| =3D 14d866d7 Allow to connect to raddb
| =3D 85269f84 FIX: compiller automatically adds .exe
| =3D d1492746 Check that user exists
|/ =20
o 972cfe1e Change fields order




I do not want this 6f899f6a merge:


kes@work ~/s $ git tree
*   6f899f6a (HEAD -> dash_v3, origin/dash_v3) Merge branch 'dash_v3' of ht=
tps://tracker.f
|\ =20
| * afacb2ab FIX: "my" variable $user masks earlier declaration in same sco=
pe at ...
| * 77e834bb Admin menu in alphabetical order
| * 3bdfdfb1 Allow to configure Grafana domain for statistic
| * 382b5014 I do not know port for custom config
| * 9fc7a9c6 Use 'bridge' mode by default
| * 94ba81eb Changes in the address staff -> cabinet
| * bd742589 Fix problems when user opens link at multiple tabs
| * 257dcef4 Configure ContactUs variable
| * 5ad4822f Reduce level acces for ContactUs form
| * a553700b Fix variable name
| * 143d8975 Force mailing for new order and registration purpose
| * d1e3477c Rewrite condition. Add logging
| * 34392eff Log more
| * 97047ffd Log message when email was sent
| * 98255b99 Fix template name
| * b1469892 Reduce right requirements for remind form
| * 6e2006ae ID is not requred for registration
| * f54b638a Change flow how registration and ordering work
| * 8a75a742 Use &debug instead of hardcode check
| * 5d629de7 Create order from session data
| * 0e2e7506 Implement new configuration option: activation_hash_length
| * b5bf701d Prevent deep recursion when calling App::config
| * b10ef0d1 Security note
| * 8835655d Implement T_INSECURE function to allow calls to ->create
| * 1ecfeac9 Allow to export &log
| * 2c89558a Do not pass whole object. Pass just required info: email
| * e33af63f $c->uid is called at previous expression
| * 0686758a Ask mail for ordering
| * 05e7ed08 Do not display cabinet menu if user is not logged in
| * db03226c Display for logged in user more text
| * 500b856a FIX: Missing or empty input at ...
| * 83230f35 Imlement utility to easy work with database
| * d65148d8 Pass 'role' explicit
| * 5f1a57b6 Add key expiration for Redis
| * bc5850dd Simplify code
| * a850b734 Improve helper functions
| * 2244724d Security note!
| * f48ad97a Implement helper to work with Redis
| * e31f2e6c Install Redis
| * e27c03a5 Changed the display of creating PayPal invoice
| * 47286618 Adding App :: Do to Controllers
| * 409447c9 Rework routes
| * 45de583d Hide menu if user is not logged in
| * 5a5eb2b9 Update password for current logged in user
| * 359b66b9 Add $user parameter
| * 4a522108 Use short description for manual invoice
| * 2e2ff2c3 Fix spacing
| * b2b5b16d Typo fix
| * 8a6c921d Do not try to find tariff for manual invoice
| * ae59ef57 Filter invoice duplicates
| * ac5bc0da Move comment
| * 2fd9c87a Fix registration link
| * 18559b63 Added order information (ip, country, city, browser)
| * fdb0f70d Active display in listener / show template changed
| * 73261cd5 Changing the creation and editing of a listener
| * a0fddafd Changing validator parameters in a Listener controller
| * ae5f6796 Put correct quoting
| * 0149b316 Fix display message
| * f4e33cbe Implemente del_stat for Grafana
| * 42d5af8a Prettify error message
| * 67da86de Invalidate link after password is set
| * 6ac55a49 Remove STAGING mode
| * dd5a02c5 Fix openvpn generator
| * 1e2cadf6 Force :id for user
| * 9fb16671 Fix authorization
| * 4882698d After user creation $user->D returns undef, but should return =
default {}
| * 333de78a Remove two factor
| * 88c81aac Fix spelling
| * 5616133f Rewrite order process
| * 328fed71 Do not try to find undef values
| * bea391f9 Remove wizard
| * b6c75889 Display email in change password form
| * b3769ecf Fix text
| * 0cc7a880 Makeup form option form sub
| * 1ad64a7a Rework change password process
| * d58c69ca Rename template
| * 509f83b5 Fix text
| * b55fca77 Template rename: remind -> link_sent
| * 62eed3c6 Renamed: set_options -> save_cart
| * 0169cb67 Display verification link in development mode
| * d8e3930c Renamed: $g -> $self
| * 61cc36d5 Put grafana keys together
| * 4c007e84 Function =F1reation delete_user
| * 40d2caa2 Typo fix
| * 2dbc6262 Store grafana datasource and user id for user
| * cc79b4bd Added drop_influxdb
| * c5e15f76 Implementing the Terminate Function
| * c681beae Fix class for links
| * 6afaf67b Fix call
| * 7b1eae08 Temporary disable 'Request late payment' button
| * c57c8bd5 Fix link to PP invoice. Now it is highlighted
| * bd115260 Fix due_date for PayPal
| * 0c1d0414 Fix order by admin
| * af00c1df Use 'bridge' mode by default
| * 7eaf74ad BUG: Do not send fwtag if firewall is OFF
| * c8d7c603 More checks for error
| * a8958e88 To reset vpn keys we just create new account
| * 36772ffe More logging
| * 4edb5e16 Provide names for arguments
| * 4c705c99 Implement global logging variable
| * 0b817b04 Disable connection cache
| * 0fad0bfb FIX: Use of uninitialized value in lc at ...
| * d7842855 Fix route name
| * 0826d061 Use dispatch table
| * 38eac024 Fix call convention
| * 286bb9e8 Fix manage page
| * b6d07840 Fix values
| * f8f8fb3f Restrict access
| * 17ce2324 Use new interface to lookup listen_ip
| * c0807de3 Improve error message
| * 7cc32b3e Remove detect_listener in favor of $package->listener_ip
| * b5ac1176 Return own address or take default from server
| * 7cae0c67 Look listeners by tariff type
| * af6f7af1 Move code into its own sub
| * 940f53c3 Hide Options in production mode
| * 722d7043 Do correct error reporting
| * 842b1c54 Display error message for admin
| * 7d9575c3 Add graphana template to the repo
| * dd03b23c Fix path to graphna file
| * 60ed9f9e Select additionally id as workaround
| * ad2f69df Localities editing in order / edit template
| * b1b1efd0 Correcting the display of parameters in the order / show templ=
ate
| * 551ad717 Passing a parameter when ordering a package
| * 90ac72e2 Hardcode removed
| * 0c3c90b9 Ability to select only active localities
| * 1fe503e6 Move category/sub_category into its own subroutin
| * 9adc0948 Fix problem with select field
| * fa492730 Make Server tag not required
| * e191fe98 Do not do changes at Mojolicous modules
| * 3ded8b0d Add webhooks for GoPay
| * 9172465c FIX: Undefined subroutine &App::Util::register_state_mapping c=
alled at ...
| * 447a4292 Fixed canceled to cancelled
| * ad3f99a7 Replacing Cancel with Back
| * 4c97ec4c Changing brackets in a query
| * 85bca306 Locality in order template
| * 3a0beb4a Changed state display in Order
| * bc5b1a69 Changed state display in Package
| * eee04065 Changed the mapping of state to IP
| * 4934e0de Split mapping hashes by type
| * 087a1e69 Fix Checkbox
| * 0be542fd Implement state mapping
| * a4e15cc1 Disable gopay in production mode
| * 33d0b44d Fix configuration value
| * e74c1c86 Move excess config from stagings
| * a2ec2bb0 Do not try to display link to order for manual Invoices
| * 5d1859b8 Inherit {mountpoint} from main configuration file
| * fc8948b5 Use new contacts
| * 23b0f3bc Fix key on l2tp_key
| * 7ba61f44 Adding and removing nas_ip and listen_ip in the Server table
| * aacd3365 listen_ip is not created
| * 16fb5b82 Fixed key on l2tp_key
| * db21c2cc SCHEMA 102: Duplicate listen_ip and nas_ip in Server table
| * 51db2dee Button color change
| * 66577eb4 Implemented removal of listener in server template
| * 95e5b893 Implemented adding listener in server template
| * d152d2fe Editing a listener from a server template
| * 8884331f Pass related table directly
| * 78cd4b6c Fix checkbox invoice
| * ad6d29e3 Add Grafana configuration for prod
| * 48505a48 FIX: Can't locate object method "listen_ip" at ...
| * cd5921f3 Fix template path and replace text by actual values
| * 4a0004d1 Link to grafana stat
| * 08becf0b Create grafana stat automatically
| * 91c094c6 Create new package API
| * 73264a30 SCHEMA 101: Add options field into User table
| *   19b6f122 Merge remote-tracking branch 'dash_v3' into dash_v3
| |\ =20
| | * aec9930b Implemented output and saving of the name field from the Ser=
ver table
| | * e22df3cf SCHEMA 100: Added column name to Server table
| | * 72baca16 SCHEMA 99: fix server constraint on IP
| | * 78bc4523 Saving ip in server table
| | * 926cc240 SCHEMA 98: Table Server. ip_id to ip
| | * 71345a1d Moving DNS keys from Subnet to Server
| | * 5bd6103c SCHEMA 97: Moving DNS keys
| | * 79649d18 Added checkbox active in listener templates.
| | * 4997c195 SCHEMA 96: Added Active field in Listener table.
| | * c5855ca4 Implemented saving keys from CONCONFIGS
| * | b93f0317 Init variable with application root directory
| * | cb7b0e1e Move App::Do::config into App
| * | 8878d495 Create grafana dashboard for given folder
| * | 34b62277 Create template with variables for grafana dashboard
| * | c49f24e0 Optimize code a bit
| * | ac391135 Send UID only for cmd of type 2
| * | 8bec1d57 User MUST be lowercased
| * | b793888d Select first parameter only. Fix syntax
| * | d6cf2108 Revert "Put txid at the end of command"
| * | 1d42e76a Revert "Typo fix"
| * | 3f945dae Connect to correct NAS server
| * | 4301edc4 Limint usertag by 10symbols
| * | 120e0250 Typo fix
| * | 4a81c77d Put txid at the end of command
| * | 9fb20d38 Pass flag to generate new port or not
| * | 23fdc513 Return $listener:$port
| * | af43241f Fetch listen_ip and return it
| * | a1bcfb14 Do not forget to load module
| * | 94ada113 Be more strict. Declare variables
| * | ff1898ea Call method instead of direct access
| * | 93838043 Create folder via Grafana API
| * | 96997eab Implement other subroutines
| * | 22da80e5 Use grafana plugin
| * | a06ab4a7 Grafana does not allow to create users using token
| * | 8f4e6666 Implemented basic functions to speak to Grafana API
| * | f030c245 Changed scp to rsync
| * | de662afc (tag: v1.0) Fix configuration files
| * | cda5e0c6 Do not display 'config' option for PPTP/L2TP packages
| * | 32a0d87d Get correct listener IP for different tariffs
| * | cb18e74c Move captcha to login form
| |/ =20
| * 412bff9f Fix template
| * 38ceba41 Refinement of display of openvpn tariff data
| * 95d00f9f Fix Options
| * 21764a1e Captcha
| * cf153349 Implemented ssl_key saving
| * cf379600 add fixed captcha and copyKey
| * b9675add Display suspended packages
| * aaa61c87 Fix sub name
| * fea1588f Display status for suspended package
| * 1744b66c FIX: Use of uninitialized value $value in concatenation (.) or=
 string at ...
| * 44fe0adf Remove excess parameter
| * dc3348d0 Fix condition
| * 14d866d7 Allow to connect to raddb
| * 85269f84 FIX: compiller automatically adds .exe
| * d1492746 Check that user exists
* | 8ad1a35b add form_section
* | 0d42d957 add fixed captcha and copyKey
* | 89d448f1 Display suspended packages
* | c4b2eb0f Fix sub name
* | 88151d09 Display status for suspended package
* | d049b926 FIX: Use of uninitialized value $value in concatenation (.) or=
 string at ...
* | ecc644d4 Remove excess parameter
* | 305f2cf8 Fix condition
* | ade88b4b Allow to connect to raddb


so I git checkout to top of my branch and chery-pick "< 8ad1a35b add form_s=
ection"

kes@work ~/s $ gc afacb2ab=20
Note: switching to 'afacb2ab'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at afacb2ab FIX: "my" variable $user masks earlier declaration =
in same scope at ...
kes@work ~/s $ git br -D dash_v3
Deleted branch dash_v3 (was 6f899f6a).
kes@work ~/s $ gc -b dash_v3
Switched to a new branch 'dash_v3'
kes@work ~/s $ git cp 8ad1a35b
[dash_v3 d2f5c866] add form_section
 Author: JekaPryadkoWeb <jekapryadko@gmail.com>
 Date: Fri Feb 28 16:31:30 2020 +0200
 1 file changed, 5 insertions(+), 3 deletions(-)
kes@work ~/s $ git tree
* d2f5c866 (HEAD -> dash_v3) add form_section
* afacb2ab FIX: "my" variable $user masks earlier declaration in same scope=
 at ...
* 77e834bb Admin menu in alphabetical order
* 3bdfdfb1 Allow to configure Grafana domain for statistic
* 382b5014 I do not know port for custom config
* 9fc7a9c6 Use 'bridge' mode by default
* 94ba81eb Changes in the address staff -> cabinet
* bd742589 Fix problems when user opens link at multiple tabs
* 257dcef4 Configure ContactUs variable
* 5ad4822f Reduce level acces for ContactUs form
* a553700b Fix variable name
* 143d8975 Force mailing for new order and registration purpose
* d1e3477c Rewrite condition. Add logging
* 34392eff Log more
* 97047ffd Log message when email was sent
* 98255b99 Fix template name
* b1469892 Reduce right requirements for remind form
* 6e2006ae ID is not requred for registration
* f54b638a Change flow how registration and ordering work
* 8a75a742 Use &debug instead of hardcode check
* 5d629de7 Create order from session data
* 0e2e7506 Implement new configuration option: activation_hash_length
* b5bf701d Prevent deep recursion when calling App::config
* b10ef0d1 Security note
* 8835655d Implement T_INSECURE function to allow calls to ->create
* 1ecfeac9 Allow to export &log
* 2c89558a Do not pass whole object. Pass just required info: email
* e33af63f $c->uid is called at previous expression
* 0686758a Ask mail for ordering
* 05e7ed08 Do not display cabinet menu if user is not logged in
* db03226c Display for logged in user more text
* 500b856a FIX: Missing or empty input at ...
* 83230f35 Imlement utility to easy work with database
* d65148d8 Pass 'role' explicit
* 5f1a57b6 Add key expiration for Redis
* bc5850dd Simplify code
* a850b734 Improve helper functions
* 2244724d Security note!
* f48ad97a Implement helper to work with Redis
kes@work ~/s $ gpf origin dash_v3
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 677 bytes | 677.00 KiB/s, done.
Total 8 (delta 7), reused 0 (delta 0)
To https://tracker.feel-safe.net/gitdev/main.git
 + 6f899f6a...d2f5c866 dash_v3 -> dash_v3 (forced update)


When  I  did  this  successfully  then git shows that **target commits
differs**. Notice they marked as < but I expect =3D

kes@work ~/s $ git changesfull 6f899f6a...d2f5c866
=3D d2f5c866 (HEAD -> dash_v3, origin/dash_v3) add form_section
| <   6f899f6a Merge branch 'dash_v3' of https://tracker.feel-safe.net/gitd=
ev/main into da
| |\ =20
| |/ =20
|/|  =20
| =3D 8ad1a35b add form_section
| < 0d42d957 add fixed captcha and copyKey
| < 89d448f1 Display suspended packages
| < c4b2eb0f Fix sub name
| < 88151d09 Display status for suspended package
| < d049b926 FIX: Use of uninitialized value $value in concatenation (.) or=
 string at ...
| < ecc644d4 Remove excess parameter
| < 305f2cf8 Fix condition
| < ade88b4b Allow to connect to raddb
| < 91d1699f FIX: compiller automatically adds .exe
| < b83f1394 Check that user exists
| o 972cfe1e Change fields order
o afacb2ab FIX: "my" variable $user masks earlier declaration in same scope=
 at ...

I expect 972cfe1e..0d42d957 should be marked as =3D, because they are at bo=
th branches.
This is probably because root-point should be not top of my branch afacb2ab=
, but somewhere deeper in the history (see first branch comparison: 8ad1a35=
b...afacb2ab)



--=20
Best regards,
Eugen Konkov

